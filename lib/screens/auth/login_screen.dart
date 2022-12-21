import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/models/alumno.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';

class LoginScreen extends StatefulWidget {
   
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // TextControllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Manejo de llaves de formulario
  final GlobalKey<FormState> _myFormKey = GlobalKey();

  Future signIn() async{
    // Carga mientras se resuelve el Future
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Intentar iniciar sesion
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );

      // Hace pop a la pantalla de carga
      Navigator.pop(context);

      // Llama al autenticador para revisar el estado
      Navigator.pushNamedAndRemoveUntil(context, 'authScreen', (route) => false);

    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      print('Falla con codigo: ${e.code}');
      print(e.message);
      errorMessage();
      // dispose();
    }
    
  }

   // Mensaje de error general para cualquier codigo devuelto
  void errorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              'Usuario o contraseña incorrectos',
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

  @override
  Widget build(BuildContext context) {

    final _alumno = Alumno();

    final Map<String, String> formValues = {
      'nombre': 'Omar Imanol',
      'apellido_paterno' : 'Rivero',
      'apellido_materno' : 'Ronquillo',
      'email'     : 'imarivero@outlook.com',
      'password'  : '123',
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _myFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Center(
                  child: Text('Iniciar Sesión', 
                    style: GoogleFonts.inter(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,)
                  ),
                ),
        
                const SizedBox(height: 170,),
            
                CustomInputTextField(
                  hintText: 'Correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  formProperty: 'correo',
                  formValues: formValues,
                  controller: _emailController,
                  // validator: (value) => RegexConst.validarCorreo(value),
                  // validator: (value) => 'Prueba',
                  validator: (value) => RegexConst.validarCorreo(value),
                ),
            
                const SizedBox(height: 15,),
            
                CustomInputTextField(
                    hintText: 'Contraseña',
                    obscureText: true,
                    formProperty: 'password',
                    formValues: formValues,
                    controller: _passwordController,
                    validator: (value) => RegexConst.validarContrasena(value),
                  ),
            
                  const SizedBox(height: 15,),
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        if(!_myFormKey.currentState!.validate()){
                          // print('form invalido');
                          return;
                        }
                        signIn();
                      },
                      child: const Text('Entrar', style: TextStyle(fontSize: 20),),
                    ),
                  ),
        
                  const SizedBox(height: 40,),
        
                  const _CuentaExistente(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class _CuentaExistente extends StatelessWidget {
  const _CuentaExistente({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '¿Aún no tienes una cuenta?',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, 'registroScreen'),
          child: Text(
            'Regístrate ahora',
            style: GoogleFonts.inter(
              color: Colors.lightBlueAccent
            ),
          ),
        ),
      ],
    );
  }
}