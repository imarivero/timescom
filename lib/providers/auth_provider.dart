import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_fonts/google_fonts.dart';

import 'package:timescom/models/alumno.dart';

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
  String user_id = '';

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

  // Constructor con nombre, inicializa _firebaseAuth al ser llamado
  // AuthProvider.instance() : _firebaseAuth = auth.FirebaseAuth.instance{
  //   FirebaseAuth.instance.authStateChanges().listen((event) {
      
  //   });
  // }

  // Future _onAuthStateChange(auth.User user) async{
  //   if(user == null){
  //     _status = AuthStatus.unauthenticated;
  //   } else{
  //     // Llama al provider de usuario
  //     // _userProvider.setFromFirestore(userSnap);
  //     _status = AuthStatus.authenticated;
  //   }
  //   notifyListeners();
  // }

  Future<Alumno?>? emailUserLogin(String email, String password, BuildContext context) async{
    _status = AuthStatus.authenticating;
    notifyListeners();

    // Intentar iniciar sesion
    try{

      auth.UserCredential userCredential =  await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user_id = userCredential.user!.uid;
      _status = AuthStatus.authenticated;
      notifyListeners();

      // return Alumno.initCredentials(userCredential.user!.uid, userCredential.user!.email!);
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
      notifyListeners();

      // return Alumno.initCredentials(userCredential.user!.uid, userCredential.user!.email!);
      return _userFromFirebase(userCredential.user);

    } on auth.FirebaseAuthException catch (e){
      // print('Falla con codigo: ${e.code}');
      // print(e.message);
      if(e.code == 'email-already-in-use'){
        errorMessage('Error: El email ya ha sido registrado previamente', context);
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

  // Mensaje de error general para cualquier codigo devuelto
  void errorMessage(String mensaje, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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