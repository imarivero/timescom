import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:timescom/models/registro_acciones.dart';
import 'package:timescom/helpers/datetime_extensions.dart';

class RegistrosProvider with ChangeNotifier{

  final _firestore = FirebaseFirestore.instance;
  List<RegistroAcciones> listaRegistros = [];

  RegistroAcciones? registroSemanaActual;
  RegistroAcciones? registroSemanaPasada;

  String idAlumno = '';
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  RegistrosProvider(){
    print('Registros provider iniciado');
  }

  /// Crea un nuevo registro en firestore y regresa el mapa
  ///  con el id del registro, o un null en caso de fallar
  Future<Map<String, dynamic>?> crearRegistro(Map<String, dynamic> newRegistroAccion) async{
    try{
      await _firestore
      .collection('alumno_registros')
      .doc(idAlumno)
      .set({'modificacion': FieldValue.serverTimestamp()});
    
      
      DocumentReference<Map<String, dynamic>> doc = await _firestore
        .collection('alumno_registros')
        .doc(idAlumno)
        .collection('registros')
        .add(newRegistroAccion);

      await _firestore
        .collection('alumno_registros')
        .doc(idAlumno)
        .collection('registros')
        .doc(doc.id)
        .update({'id_registro': doc.id});


      newRegistroAccion['id_registro'] = doc.id;

      registroSemanaActual = RegistroAcciones.registroFromMap(newRegistroAccion);
      listaRegistros.add(registroSemanaActual!);

      // Actividad temporal = Actividad.actividadFromMap(newActividad);
      // listActividades.add(temporal);

      notifyListeners();

      return newRegistroAccion;
    } on FirebaseException catch (e){
      print(e.message);
      return null;
    }
  }
  
  
  Future<void> getRegistros(String idAlumno) async{

    this.idAlumno = idAlumno;
    DateTime dateNow = DateTime.now();
    String dayQuery = '';
    // Domingo de la semana pasada
    DateTime lastSunday = dateNow.beginningOfWeek.subtract(const Duration(days: 1));

    // String dayQuery = '${lastSunday.day}-${lastSunday.month}-${lastSunday.year}';
    dayQuery = formatter.format(lastSunday);

    try{
      
      await _firestore
      .collection('alumno_registros')
      .doc(idAlumno)
      .collection('registros')
      .where('fecha_final', isEqualTo: dayQuery)
      .get().then((coleccion) {
        for(var registro in coleccion.docs){
          // Deberia traer solo uno, que es el de la semana pasada siempre que exista
          print(registro.data());

          Map<String, dynamic> mapaRegistro = registro.data();
          mapaRegistro = convertirRegistros(mapaRegistro);

          listaRegistros.add(RegistroAcciones.registroFromMap(mapaRegistro));
          registroSemanaPasada = RegistroAcciones.registroFromMap(mapaRegistro);
        }
      });
      
      // Domingo de la semana actual
      // dayQuery = '${dateNow.endOfWeek.day}-${dateNow.endOfWeek.month}-${dateNow.endOfWeek.year}';
      dayQuery = formatter.format(dateNow.endOfWeek);
      
      await _firestore
      .collection('alumno_registros')
      .doc(idAlumno)
      .collection('registros')
      .where('fecha_final', isEqualTo: dayQuery)
      .get().then((coleccion) {
        for(var registro in coleccion.docs){
          // Deberia traer solo uno, que es el de esta semana siempre que exista
          print(registro.data());

          Map<String, dynamic> mapaRegistro = registro.data();
          mapaRegistro = convertirRegistros(mapaRegistro);

          listaRegistros.add(RegistroAcciones.registroFromMap(mapaRegistro));
          registroSemanaActual = RegistroAcciones.registroFromMap(mapaRegistro);
        }
      });
    } on FirebaseException catch (e){
      print(e.message);
    }
    notifyListeners();
  }

  /// Envia las modificaciones a la semana actual a firestore
  Future<void> actualizarEnFirestore(Map<String, dynamic> mapaModificaciones) async{
    try{
      await _firestore
      .collection('alumno_registros')
      .doc(idAlumno)
      .collection('registros')
      .doc(registroSemanaActual!.idRegistro)
      .update(mapaModificaciones);
    } on FirebaseException catch (e){
      print(e.message);
    }
  }

  /// Recibe el tipo de registro desde donde se solicito, y si ya hay un registro creado
  ///  de la semana actual en [registroSemanaActual], entonces incrementa el valor que tenga
  ///  el tipo de registro que recibio, si no, llama a la funcion [crearRegistro].
  void actualizarRegistroCategoria(String tipo) async{

    final date = DateTime.now();
    
    if(registroSemanaActual == null){

      RegistroAcciones registroNuevo = RegistroAcciones.registroConDatosIniciales();
      
      switch (tipo) {
        case 'habito':
          registroNuevo.registroHabitos = mapaDiasInicial(date.nombreDia);
          break;
        case 'actividad':
          registroNuevo.registroActividades = mapaDiasInicial(date.nombreDia);
          break;
        case 'pomodoro':
          registroNuevo.registroPomodoros = mapaDiasInicial(date.nombreDia);
          break;
        default:
          break;
      }
      await crearRegistro(registroNuevo.mapFromRegistroAcciones());

    }else {
      Map<String, dynamic> mapaModificaciones = {};
      Map<String, int> mapaDiasModificado = {};

      switch (tipo) {
        case 'habito':
          mapaDiasModificado = mapaDiasIncrementado(registroSemanaActual!.registroHabitos, date.nombreDia);
          registroSemanaActual!.registroHabitos = mapaDiasModificado;
          mapaModificaciones['registro_habitos'] = mapaDiasModificado;
          break;
        case 'actividad':
          mapaDiasModificado = mapaDiasIncrementado(registroSemanaActual!.registroActividades, date.nombreDia);
          registroSemanaActual!.registroActividades = mapaDiasModificado;
          mapaModificaciones['registro_actividades'] = mapaDiasModificado;
          break;
        case 'pomodoro':
          mapaDiasModificado = mapaDiasIncrementado(registroSemanaActual!.registroPomodoros, date.nombreDia);
          registroSemanaActual!.registroPomodoros = mapaDiasModificado;
          mapaModificaciones['registro_pomodoros'] = mapaDiasModificado;
          break;
        default:
          break;
      }
      await actualizarEnFirestore(mapaModificaciones);
    }

    notifyListeners();
  }

  /// Recibe como parametro el nombre abreviado del dia y devuelve un mapa con ceros para
  ///  todos los dias excepto el recibido, que regresa con un 1.
  Map<String, int> mapaDiasInicial(String nombreDia){

    Map<String, int> mapaDias = {};

    mapaDias.addAll({
      'Lu' : 0,
      'Ma' : 0,
      'Mi' : 0,
      'Ju' : 0,
      'Vi' : 0,
      'Sa' : 0,
      'Do' : 0,
    });

    mapaDias[nombreDia] = 1;

    return mapaDias;
  }
  
  /// Recibe como parametro el nombre abreviado del dia [nombreDia] y el mapa de dias cargado en memoria,
  ///  luego devuelve un mapa con los valores que tiene ya cargados el mapa con el incremento del registro 
  /// dependiendo del dia que recibio
  Map<String, int> mapaDiasIncrementado(Map<String, int> mapaDias, String nombreDia){

    if(mapaDias.isEmpty){
      return mapaDiasInicial(nombreDia);
    } else{
      int valorInicial = mapaDias[nombreDia] ?? -1; // -1 en caso de no encontrarlo en el mapa
      valorInicial++;
      mapaDias[nombreDia] = valorInicial;
    }

    return mapaDias;
  }

  set setIdAlumno (String idAlumno){
    this.idAlumno = idAlumno;
  }

  Map<String, int> convertirDynToInt(Map<String, dynamic> mapa){
    return mapa.map((key, value) => MapEntry(key, value as int));
  }

  Map<String, dynamic> convertirRegistros(Map<String, dynamic> mapaRegistro){

    Map<String, int> mapaStringInt = {};

    if(mapaRegistro.containsKey('registro_actividades')){
      mapaStringInt = convertirDynToInt(mapaRegistro['registro_actividades']);
      mapaRegistro.remove('registro_actividades');
      mapaRegistro['registro_actividades'] = mapaStringInt;
    }
    
    if(mapaRegistro.containsKey('registro_habitos')){
      mapaStringInt = convertirDynToInt(mapaRegistro['registro_habitos']);
      mapaRegistro.remove('registro_habitos');
      mapaRegistro['registro_habitos'] = mapaStringInt;
    }
    
    if(mapaRegistro.containsKey('registro_pomodoros')){
      mapaStringInt = convertirDynToInt(mapaRegistro['registro_pomodoros']);
      mapaRegistro.remove('registro_pomodoros');
      mapaRegistro['registro_pomodoros'] = mapaStringInt;
    }

    mapaStringInt.clear();
    
    return mapaRegistro;
  }

  void clean(){
    listaRegistros.clear();

    registroSemanaActual = null;
    registroSemanaPasada = null;

    idAlumno = '';
  }

}