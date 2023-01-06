import 'package:intl/intl.dart';
import 'package:timescom/helpers/datetime_extensions.dart';
import 'package:week_of_year/week_of_year.dart';

class RegistroAcciones{

  String idRegistro;
  String fechaInicio;
  String fechaFinal;
  int numeroSemanaAnio;
  int numeroSemanaMes;
  Map<String, int> registroActividades;
  Map<String, int> registroHabitos;
  Map<String, int> registroPomodoros;

  RegistroAcciones(
    this.idRegistro,
    this.fechaInicio,
    this.fechaFinal,
    this.numeroSemanaAnio,
    this.numeroSemanaMes,
    this.registroActividades,
    this.registroHabitos,
    this.registroPomodoros
  );

  static RegistroAcciones registroFromMap(Map<String, dynamic> registroMap){
    return RegistroAcciones(
      registroMap['id_registro'] ?? '',
      registroMap['fecha_inicio'] ?? '',
      registroMap['fecha_final'] ?? '',
      registroMap['numero_semana_anio'] ?? '',
      registroMap['numero_semana_mes'] ?? '',
      registroMap['registro_actividades'] ?? {},
      registroMap['registro_habitos'] ?? {},
      registroMap['registro_pomodoros'] ?? {},
    );
  }

  Map<String, dynamic> mapFromRegistroAcciones(){
    Map<String, dynamic> mapaRegistroAcciones = {};
    mapaRegistroAcciones['id_registro'] = idRegistro;
    mapaRegistroAcciones['fecha_inicio'] = fechaInicio;
    mapaRegistroAcciones['fecha_final'] = fechaFinal;
    mapaRegistroAcciones['numero_semana_anio'] = numeroSemanaAnio;
    mapaRegistroAcciones['numero_semana_mes'] = numeroSemanaMes;
    mapaRegistroAcciones['registro_actividades'] = registroActividades;
    mapaRegistroAcciones['registro_habitos'] = registroHabitos;
    mapaRegistroAcciones['registro_pomodoros'] = registroPomodoros;

    return mapaRegistroAcciones;
  }


  /// Devuelve un objeto RegistroAcciones con los valores relacionados 
  /// a la fecha en la que se llamo
  static RegistroAcciones registroConDatosIniciales(){
    DateTime timeNow = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    
    return RegistroAcciones(
      '',
      formatter.format(timeNow.beginningOfWeek),
      formatter.format(timeNow.endOfWeek),
      timeNow.weekOfYear,
      timeNow.weekOfMonth,
      {},
      {},
      {},
    );
  }
}