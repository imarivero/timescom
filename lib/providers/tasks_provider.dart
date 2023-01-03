import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timescom/models/actividad.dart';

class TaskProvider with ChangeNotifier{

  final _firestore = FirebaseFirestore.instance;
  List<Actividad> listActividades = [];

  List<Actividad> listActividadesUrgIm = []; // lista urgentes + importantes
  List<Actividad> listActividadesUrgNim = []; // lista urgentes + no importantes
  List<Actividad> listActividadesNurgIm = []; // lista no urgentes + importantes
  List<Actividad> listActividadesNurgNim = []; // lista no urgentes + no importantes

  String idAlumno = '';

  TaskProvider(){
    print('Task provider iniciado');
  }

  Future<bool> addActividad(Map<String, String> newActividad) async{
    try{
      await _firestore
      .collection('alumno_actividad')
      .doc(idAlumno)
      .set({'modificacion': FieldValue.serverTimestamp()});
    
      
      DocumentReference<Map<String, dynamic>> doc = await _firestore
        .collection('alumno_actividad')
        .doc(idAlumno)
        .collection('actividades')
        .add(newActividad);

      await _firestore
        .collection('alumno_actividad')
        .doc(idAlumno)
        .collection('actividades')
        .doc(doc.id)
        .update({'id_actividad': doc.id});


      newActividad['id_actividad'] = doc.id;

      Actividad temporal = Actividad.actividadFromMap(newActividad);
      listActividades.add(temporal);
      agregarActividadListaEspecifica(temporal);

      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<bool> updateActividad(Map<String, String> modActividad, Actividad actividad) async{
    try{
      await _firestore
      .collection('alumno_actividad')
      .doc(idAlumno)
      .collection('actividades')
      .doc(actividad.idActividad)
      .update(modActividad);

      // Quita de las listas la actividad modificada
      listActividades.remove(actividad);
      removerActividadListaEspecifica(actividad);

      // Agrega de nuevo la actividad con las modificaciones
      listActividades.add(getActividadActualizada(modActividad, actividad));
      agregarActividadListaEspecifica(actividad);

      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<bool> eliminarActividad(Actividad actividad) async{
    try{
      await _firestore
      .collection('alumno_actividad')
      .doc(idAlumno)
      .collection('actividades')
      .doc(actividad.idActividad)
      .delete();

      listActividades.remove(actividad);
      removerActividadListaEspecifica(actividad);

      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<void> getActividades(String idAlumno) async{

    this.idAlumno = idAlumno;

    try{
      await _firestore
      .collection('alumno_actividad')
      .doc(idAlumno)
      .collection('actividades')
      .get().then((query){
        // Iterar los documentos de firestore
        for (var element in query.docs) {
          print(element.data());
          Actividad newActividad = Actividad.actividadFromMap(
            element.data().map((key, value) => MapEntry(key, value.toString()))
          );
          listActividades.add(newActividad);
        }
      });

    } on FirebaseException catch (e){
      print(e.message);
    }
    repartirActividades();
    notifyListeners();
  }

  set setIdAlumno (String idAlumno){
    this.idAlumno = idAlumno;
  }

  void repartirActividades(){
    for(Actividad element in listActividades){
      if(element.prioridad == 'Urgente + importante'){listActividadesUrgIm.add(element);}
      if(element.prioridad == 'Urgente + no importante'){listActividadesUrgNim.add(element);}
      if(element.prioridad == 'No urgente + importante'){listActividadesNurgIm.add(element);}
      if(element.prioridad == 'No urgente + no importante'){listActividadesNurgNim.add(element);}
    }
  }
  
  void agregarActividadListaEspecifica(Actividad actividad){
    if(actividad.prioridad == 'Urgente + importante'){listActividadesUrgIm.add(actividad); return;}
    if(actividad.prioridad == 'Urgente + no importante'){listActividadesUrgNim.add(actividad); return;}
    if(actividad.prioridad == 'No urgente + importante'){listActividadesNurgIm.add(actividad); return;}
    if(actividad.prioridad == 'No urgente + no importante'){listActividadesNurgNim.add(actividad); return;}
  }
  
  void removerActividadListaEspecifica(Actividad actividad){
    if(actividad.prioridad == 'Urgente + importante'){listActividadesUrgIm.remove(actividad); return;}
    if(actividad.prioridad == 'Urgente + no importante'){listActividadesUrgNim.remove(actividad); return;}
    if(actividad.prioridad == 'No urgente + importante'){listActividadesNurgIm.remove(actividad); return;}
    if(actividad.prioridad == 'No urgente + no importante'){listActividadesNurgNim.remove(actividad); return;}
  }

  Actividad getActividadActualizada(Map<String, String> mapa, Actividad oldActividad){

    Map<String, String> oldMap = oldActividad.mapFromActividad();

    mapa.forEach((key, value) {
      oldMap.update(key, (oldValue) => value);
    });

    return Actividad.actividadFromMap(oldMap);
  }
}