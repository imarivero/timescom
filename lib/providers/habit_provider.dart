import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timescom/models/habito.dart';

class HabitProvider with ChangeNotifier{

  final _firestore = FirebaseFirestore.instance;

  List<Habito> listHabitos = [];
  String idAlumno = '';

  HabitProvider(){
    print('Habit provider iniciado');
  }

  Future<bool> addHabito(Map<String, dynamic> newHabito) async{
    try{
      await _firestore
        .collection('alumno_habitos')
        .doc(idAlumno)
        .set({'modificacion': FieldValue.serverTimestamp()});
      
      DocumentReference<Map<String, dynamic>> doc =  await _firestore
        .collection('alumno_habitos')
        .doc(idAlumno)
        .collection('habitos')
        .add(newHabito);

      await _firestore
        .collection('alumno_habitos')
        .doc(idAlumno)
        .collection('habitos')
        .doc(doc.id)
        .update({'id_habito': doc.id});

      newHabito['id_habito'] = doc.id;

      listHabitos.add(Habito.habitoFromMap(newHabito));
      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<bool> updateHabito(Map<String, dynamic> modHabito, Habito oldHabito) async{
    try{
      await _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .collection('habitos')
      .doc(oldHabito.idHabito)
      .update(modHabito);

      listHabitos.remove(oldHabito); 

      Habito newHabito = getHabitoActualizado(modHabito, oldHabito);

      listHabitos.add(newHabito);

      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<bool> eliminarHabito(Habito habito) async{
    try{
      await _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .collection('habitos')
      .doc(habito.idHabito)
      .delete();

      listHabitos.remove(habito);

      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<void> getHabitos(String idAlumno) async{

    this.idAlumno = idAlumno;

    try{
      await _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .collection('habitos')
      .get().then((query){
        // Iterar los documentos de firestore
        for (var element in query.docs) {
          print(element.data());

          Map<String, dynamic> mapaTemporal = element.data();
          Map<String, bool> mapaDias = convertirDynToBool(mapaTemporal['dias_repeticion']);

          mapaTemporal.remove('dias_repeticion'); // Quita el que tiene String, dynamic
          mapaTemporal['dias_repeticion'] = mapaDias; // Agrega el que tiene el casteo

          listHabitos.add(Habito.habitoFromMap(mapaTemporal));
        }
      });
      notifyListeners();

    } on FirebaseException catch (e){
      print(e.message);
    }
  }

  /// Elimina todos los habitos almacenados en firestore, debería llamarse 
  /// únicamente cuando se elimina la cuenta definitivamente.
  Future<void> borrarTodo() async{
    try{
      // Trae todos los documentos para tener las referencias
      QuerySnapshot<Map<String, dynamic>> coleccion = await _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .collection('habitos')
      .get();

      // Elimina documento por documento
      for(var doc in coleccion.docs){
        doc.reference.delete();
      }

      // Elimina el documento padre que contiene el id del alumno
      _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .delete();

    } on FirebaseException catch (e){
      print(e.message);
    }
  }

  set setIdAlumno (String idAlumno){
    this.idAlumno = idAlumno;
  }


  Habito getHabitoActualizado(Map<String, dynamic> mapa, Habito oldHabito){

    Map<String, dynamic> oldMap = oldHabito.mapFromHabito();

    mapa.forEach((key, value) {
      oldMap.update(key, (oldValue) => value);
    });

    return Habito.habitoFromMap(oldMap);
  }

  Map<String, bool> convertirDynToBool(Map<String, dynamic> mapa){

    return mapa.map((key, value) => MapEntry(key, value as bool));
  }

  void clean(){
    listHabitos.clear();
    String idAlumno = '';
  }
}