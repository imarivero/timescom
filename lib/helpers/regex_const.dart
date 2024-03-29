class RegexConst{

  static final namePattern = RegExp(
    r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+(([',. -][a-zA-ZáéíóúÁÉÍÓÚñÑ])?[a-zA-ZáéíóúÁÉÍÓÚñÑ]*)*?$",
    caseSensitive: false, 
    // unicode: false, 
    // dotAll: true
  );

  static final emailPattern = RegExp(r'^\S+@\S+\.\S+$');
  static final emailPatternInstitucional = RegExp(r'^[a-z0-9]+@((alumno\.ipn\.)|(ipn\.))+(mx)+$');


  static String? validarCorreo(String? correo){
    if(correo == null){
      return null;
    }
    if(correo.isEmpty){
      return 'Ingresa tu correo institucional';
    } else if(!emailPatternInstitucional.hasMatch(correo)){
      return 'Ingresa un correo institucional válido';
    }
    else{
      return null;
    }
  }
  
  static String? validarCorreoActualizado(String? correo){
    if(correo == null){
      return null;
    }
    if(correo.isNotEmpty && !emailPatternInstitucional.hasMatch(correo)){
      return 'Ingresa un correo institucional válido';
    }
    else{
      return null;
    }
  }
  
  static String? validarContrasena(String? contrasena){
    if(contrasena == null){
      return null;
    }
    if(contrasena.isEmpty){
      return 'Ingresa tu contraseña';
    }
    if(contrasena.length < 6){
      return 'La contraseña debe de tener al menos 6 caracteres';
    }
    else{
      return null;
    }
  }

  static String? validarNombre(String? value){
    if(value == null){
      return null;
    }
    else if(value.isEmpty){
      return 'Ingresa tu nombre';
    }
    else if(namePattern.hasMatch(value)){
      return null;
    } else {
      return 'Ingresa un nombre válido';
    }
  }
  
  static String? validarApellidoPat(String? value){
    if(value == null){
      return null;
    }
    else if(value.isEmpty){
      return 'Ingresa tu apellido';
    }
    else if(namePattern.hasMatch(value)){
      return null;
    } else {
      return 'Ingresa un apellido válido';
    }
  }
  
  static String? validarApellidoMat(String? value){
    if(value == null || value.isEmpty){
      return null;
    }
    else if(namePattern.hasMatch(value)){
      return null;
    } else {
      return 'Ingresa un apellido válido';
    }
  }
  
  static String? validarTitulo(String? value){
    if(value == null || value.isEmpty){
      return 'Ingresa al menos un titulo';
    } else if(value.trim().isEmpty){
      return 'Título no puede ser únicamente espacios en blanco';
    }
    else {
      return null;
    }
  }

  static String? validarTituloModificado(String? value){
    if(value == null || value.isEmpty){
      return null;
    } else if(value.trim().isEmpty){
      return 'Título no puede ser únicamente espacios en blanco';
    }
    else {
      return null;
    }
  }
  
  static String? validarDescripcion(String? value){
    if(value == null || value.isEmpty){
      return null;
    } if (value.isNotEmpty && value.trim().isEmpty){
      return 'Descripcion no puede ser únicamente espacios en blanco';
    } else {
      return null;
    }
  }
}