class RegexConst{

  static final namePattern = RegExp(
    r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$",
    caseSensitive: false, 
    unicode: true, 
    dotAll: true
  );

  static final emailPattern = RegExp(r'^\S+@\S+\.\S+$');

  static final emailPatternInstitucional = RegExp(r'^[a-z0-9]+@((alumno\.ipn\.)|(ipn\.))+(mx)+$');

  static String? validarCorreo(String? correo){
    if(correo == null){
      return null;
    }
    if(correo.isEmpty){
      return 'Ingresa tu correo institucional';
    } else if(!emailPattern.hasMatch(correo)){
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
    if(contrasena.length < 7){
      return 'La contraseña debe de tener al menos 6 caracteres';
    }
    else{
      return null;
    }
  }

  
  

  
  static bool validarCorreoBool(String? correo){
    if(correo == null){
      return false;
    }
    if(emailPattern.hasMatch(correo)){
      return true;
    }
    else{
      return false;
    }
  }
}