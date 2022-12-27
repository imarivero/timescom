
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timescom/models/alumno.dart';

class AlumnoProvider with ChangeNotifier{

  Alumno? alumno;
  final _firestore = FirebaseFirestore.instance;

  AlumnoProvider(){
    print('Alumno provider iniciado');
    alumno = Alumno.initCredentials('', '');
  }

  Future<void> addAlumnoInfo(Alumno alumno, Map<String, String> formValues) async{
    try{
      await _firestore
      .collection('alumnos')
      .doc(alumno.uid)
      .set(formValues);

      alumno = Alumno.setAlumnoValuesMap(formValues);
      notifyListeners();
    } on FirebaseException catch (e){
      print(e.message);
    }
  }

  Future<Alumno?> getAlumnoInfo(Alumno alumnoInit) async{
    print(alumnoInit.uid);

    final DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
    .collection('alumnos')
    .doc(alumnoInit.uid)
    .get()
    .then(
      (DocumentSnapshot<Map<String, dynamic>> value) {
        // Si no hay ningún documento en la ubicación a la que hace referencia docRef, 
        // el document resultante estará vacío y la llamada que exists en él devolverá false
        if(value.exists){
          alumno = Alumno.setAlumnoValuesMap(
            value.data()!.map((key, value) => MapEntry(key, value.toString()))
          );
          print(alumno!.nombre);
        }
        return value;
      },
      onError: (e) => print("Error getting document: $e"),
    );

    notifyListeners();
    return alumno;
  }

  // Alumno? _userFromFirestore()
  
}