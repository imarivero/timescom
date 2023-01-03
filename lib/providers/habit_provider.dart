import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timescom/models/habito.dart';

class HabitProvider with ChangeNotifier{

  final _firestore = FirebaseFirestore.instance;
  List<Habito> listHabitos = [];

  HabitProvider(){
    print('Habit provider iniciado');
  }

  Future<bool> addHabito(Map<String, dynamic> newHabito, String idAlumno) async{
    try{
      await _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .set({'modificacion': FieldValue.serverTimestamp()});
      
      await _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .collection('actividades')
      .add(newHabito).then((value) async{
        _firestore
        .collection('alumno_habitos')
        .doc(idAlumno)
        .collection('habitos')
        .doc(value.id)
        .update({'id_habito': value.id});
      });

      listHabitos.add(Habito.habitoFromMap(newHabito));
      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<bool> updateHabito(Map<String, dynamic> modHabito, String idAlumno, Habito oldHabito) async{
    try{
      await _firestore
      .collection('alumno_habitos')
      .doc(idAlumno)
      .collection('habitos')
      .doc(oldHabito.idHabito)
      .update(modHabito);

      listHabitos.remove(oldHabito); 
      listHabitos.add(Habito.habitoFromMap(modHabito));

      notifyListeners();

      return true;
    } on FirebaseException catch (e){
      print(e.message);
      return false;
    }
  }
  
  Future<bool> eliminarHabito(String idAlumno, Habito habito) async{
    try{
      await _firestore
      .collection('alumno_actividad')
      .doc(idAlumno)
      .collection('actividades')
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
    try{
      await _firestore
      .collection('alumno_actividad')
      .doc(idAlumno)
      .collection('actividades')
      .get().then((query){
        // Iterar los documentos de firestore
        query.docs.forEach((element) {
          // Iteracion de los elementos dentro del documento
          // element.data().forEach((key, value) {
          //   Actividad actividad = Actividad.init(titulo: '', prioridad: '');
          //   switch (key) {
          //     case 'titulo':
          //       break;
          //     case 'descripcion':
          //       break;
          //     case 'fecha_limite':
          //       break;
          //     case 'cuadrante':
          //       break;
          //     default:
          //       break;
          //   }
          // });
          // Habito newHabito = Habito.habitoFromMap(

          //   element.data().map((key, value) => MapEntry(key, value.toString()))
          // );
          // listHabitos.add(newHabito);

          print(element.data());
          listHabitos.add(Habito.habitoFromMap(element.data()));
        });
      });
      notifyListeners();

    } on FirebaseException catch (e){
      print(e.message);
    }
  }
}