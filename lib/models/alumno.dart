class Alumno{

  String nombre = '';
  String apellidoPaterno = '';
  String apellidoMaterno = '';
  String correo = '';
  String uid = '';

  Alumno.initCredentials(
    this.uid,
    this.correo,
  );

  Alumno(
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.correo,
    this.uid,
  );

  Map<String, dynamic> get alumnoMap{
    Map<String, String> alumnoMap = {
      'nombre': nombre,
      'apellido_paterno' : apellidoPaterno,
      'apellido_materno' : apellidoMaterno,
      'correo'     : correo,
      'password'  : uid,
    };
    return alumnoMap;
  }

  static Alumno setAlumnoValuesMap(Map<String, String> alumnoMap){
    return Alumno(
      alumnoMap['nombre'] == null ? '' : alumnoMap['nombre']!,
      alumnoMap['apellido_paterno'] == null ? '' : alumnoMap['apellido_paterno']!,
      alumnoMap['apellido_materno'] == null ? '' : alumnoMap['apellido_materno']!,
      alumnoMap['correo'] == null ? '' : alumnoMap['correo']!,
      alumnoMap['uid'] == null ? '' : alumnoMap['uid']!
    );
  }

}