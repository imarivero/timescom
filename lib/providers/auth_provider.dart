import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_fonts/google_fonts.dart';

import 'package:timescom/models/alumno.dart';
import 'package:timescom/widgets/widgets.dart';

enum AuthStatus{
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
}

class AuthProvider with ChangeNotifier{

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  auth.User? userAuth;
  AuthStatus _status = AuthStatus.uninitialized;
  String userId = '';

  AuthProvider(){
    print('AuthProvider iniciado');
    userAuth = _firebaseAuth.currentUser;
  }

  Alumno? alumnoLogedPreviously(){
    if(userAuth != null){
      return Alumno.initCredentials(userAuth!.uid, userAuth!.email!);
    } else{
      return null;
    }
  }

  Alumno? _userFromFirebase(auth.User? user){
    if(user == null){
      return null;
    }
    else{
      return Alumno.initCredentials(user.uid, user.email!);
    }
  }

  Stream<Alumno?>? get user{
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }


  Future<Alumno?>? emailUserLogin(String email, String password, BuildContext context) async{
    _status = AuthStatus.authenticating;

    // Intentar iniciar sesion
    try{

      auth.UserCredential userCredential =  await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      userId = userCredential.user!.uid;
      _status = AuthStatus.authenticated;
      userAuth = _firebaseAuth.currentUser;
      notifyListeners();

      return _userFromFirebase(userCredential.user);

    } on auth.FirebaseAuthException catch (e){
      print('Falla con codigo: ${e.code}');
      print(e.message);
      errorMessage('Usuario o contraseña incorrectos, revisa tus credenciales.', context);
      // errorMessage();
      // dispose();
      return null;
    }
  }
  
  Future<Alumno?>? emailUserSignUp(String email, String password, BuildContext context) async{
    _status = AuthStatus.authenticating;
    notifyListeners();

    // Intentar iniciar sesion
    try{

      auth.UserCredential userCredential = await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      _status = AuthStatus.authenticated;
      userAuth = _firebaseAuth.currentUser;

      notifyListeners();

      // return Alumno.initCredentials(userCredential.user!.uid, userCredential.user!.email!);
      return _userFromFirebase(userCredential.user);

    } on auth.FirebaseAuthException catch (e){
      // print('Falla con codigo: ${e.code}');
      // print(e.message);
      if(e.code == 'email-already-in-use'){
        errorMessage('Error: El email ya ha sido registrado previamente.', context);
      }
      else{
        errorMessage('Lo sentimos, ha habido un error, vuelve a intentarlo mas tarde', context);
      }
      // dispose();
      return null;
    }
  }

  Future<void> signOut() async{
    _status = AuthStatus.unauthenticated;

    notifyListeners();
    return await _firebaseAuth.signOut();
  }

  Future restaurarContrasena(String email, BuildContext context) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      errorMessage('¡El correo ha sido enviado! Asegurate de revisar la carpeta spam.', context, error: false);
    } on auth.FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        errorMessage('El correo ingresado no esta registrado.', context);
      } else{
        errorMessage('Lo sentimos, ha ocurrido un error. Vuelve a intentarlo mas tarde.', context);
      }
    }
  }
  
  Future actualizarPassword(String newPassword, BuildContext context) async{
    try{
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
      errorMessage('Tu contraseña ha sido actualizada exitosamente!', context, error: false);
      userAuth = _firebaseAuth.currentUser;
      notifyListeners();
    } on auth.FirebaseAuthException catch(e){
      print(e.message);
      errorMessage('Lo sentimos, ha ocurrido un error. Vuelve a intentarlo mas tarde.', context);
    }
  }
  
  Future actualizarCorreo(String newEmail) async{
    try{
      await _firebaseAuth.currentUser!.updateEmail(newEmail);
      userAuth = _firebaseAuth.currentUser;
      notifyListeners();
    } on auth.FirebaseAuthException catch(e){
      print(e.message);
    }
  }
  
  Future eliminarCuenta(BuildContext context) async{
    try{
      await _firebaseAuth.currentUser!.delete();
      // errorMessage('Tu cuenta ha sido eliminada exitosamente!', context, error: false);
      await PopMessage.message('Tu cuenta ha sido eliminada exitosamente!', context, error: false);
      await signOut();
    } on auth.FirebaseAuthException catch(e){
      print(e.message);
      errorMessage('Lo sentimos, ha ocurrido un error. Vuelve a intentarlo mas tarde.', context);
    }
  }
  
  Future<bool> reAuthAlumno(BuildContext context, String password) async{

    bool validacion = false;

    auth.AuthCredential credentials = auth.EmailAuthProvider.credential(
      email: userAuth!.email!,
      password: password
    );

    try{
      await _firebaseAuth.currentUser!.reauthenticateWithCredential(credentials);
      print('Reautenticado con exito');
      validacion = true;
      errorMessage('Contraseña validada!', context);
    } on auth.FirebaseAuthException catch(e){
      print(e.message);
      errorMessage('Contraseña incorrecta, vuelve a intentarlo', context);
    }
    return validacion;
  }

  // Mensaje de error general para cualquier codigo devuelto
  errorMessage(String mensaje, BuildContext context, {bool error = true}) async{
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: error == false ? const Icon(Icons.check) : const Icon(Icons.error),
          title: Center(
            child: Text(
              mensaje,
              // 'Lo sentimos, ha habido un error, vuelve a intentarlo mas tarde',
              style: GoogleFonts.inter(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar', style: TextStyle(fontSize: 20),)
          ),
        );
      },
    );
  }
}