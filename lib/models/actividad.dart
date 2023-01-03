
class Actividad{

  String titulo;
  String? descripcion;
  String? fechaLim;
  String prioridad;
  String? idActividad;

  Actividad.init({
    required this.titulo,
    required this.prioridad
  });

  Actividad(
    this.titulo,
    this.descripcion,
    this.fechaLim,
    this.prioridad,
    this.idActividad,
  );

  void crearActividad(){

  }

  void modificarActividad(){

  }

  void eliminarActividad(){

  }

  static Actividad actividadFromMap(Map<String, String> actividadMap){
    return Actividad(
      actividadMap['titulo'] == null ? '' : actividadMap['titulo']!,
      actividadMap['descripcion'] == null ? '' : actividadMap['descripcion']!,
      actividadMap['fecha_limite'] == null ? '' : actividadMap['fecha_limite']!,
      actividadMap['prioridad'] == null ? '' : actividadMap['prioridad']!,
      actividadMap['id_actividad'] == null ? '' : actividadMap['id_actividad']!,
    );
  }
  
  Map<String, String> mapFromActividad(){
    
    Map<String, String> mapaActividad = {};
    mapaActividad['titulo'] = titulo;
    mapaActividad['descripcion'] = descripcion == null ? '' : descripcion!;
    mapaActividad['fecha_limite'] = fechaLim == null ? '' : fechaLim!;
    mapaActividad['prioridad'] = prioridad;
    mapaActividad['id_actividad'] = idActividad == null ? '' : idActividad!;

    return mapaActividad;
  }
}