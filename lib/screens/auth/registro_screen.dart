import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/models/alumno.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';

class RegistroScreen extends StatefulWidget {
   
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {

  // TextControllers
  final _nombreController = TextEditingController();
  final _apePaternoController = TextEditingController();
  final _apeMaternoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final Map<String, String> formValues = {
    'nombre': 'Juan',
    'apellido_paterno' : 'Doe',
    'apellido_materno' : '',
    'fecha_creacion': DateTime.now().toString(),
    'correo'     : 'john.doe@outlook.com',
    'password'  : '123456',
  };

  Future registrarAlumno() async{

    // Verifica si las contrasenas ingresadas son iguales
    if(confirmacionPassword()){
      // Carga mientras se resuelve el Future
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Intentar registrar usuario
      try{

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
        );

        // Agregar detalles de alumno
        formValues.remove('password');
        formValues.remove('password_check');
        DocumentReference docRef = await FirebaseFirestore.instance.collection('alumnos').add(formValues);
        
        // Agregar id de usuario autogenerado
        await FirebaseFirestore.instance.collection('alumnos')
          .doc(docRef.id)
          .set(
            {'alumno_id':docRef.id},
              SetOptions(merge: true)
        );
        formValues.addAll({'alumno_id':docRef.id});

        // Hace pop a la pantalla de carga
        Navigator.pop(context);

        // Llama al autenticador para revisar el estado
        Navigator.pushNamedAndRemoveUntil(context, 'authScreen', (route) => false);

      } on FirebaseAuthException catch (e){

        Navigator.pop(context);
        // print('Falla con codigo: ${e.code}');
        // print(e.message);
        if(e.code == 'email-already-in-use'){
          errorMessage('Error: El email ya ha sido registrado previamente');
        }
        else{
          errorMessage('Lo sentimos, ha habido un error, vuelve a intentarlo mas tarde');
        }
      }
    } else{
      errorMessage('Error: Las contraseñas no son iguales, por favor, verifica tus datos');
    }
  }

  // Mensaje de error general para cualquier codigo devuelto
  void errorMessage(String mensaje) {
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

  bool confirmacionPassword(){
    if(_passwordController.text == _confirmPasswordController.text){
      return true;
    } else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> myFormKey = GlobalKey();
    final _alumno = Alumno();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: myFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Center(
                  child: Text('Registro', 
                   style: GoogleFonts.inter(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,)
                  ),
                ),

                const SizedBox(height: 30,),

                CustomInputTextField(
                  hintText: 'Nombre(s)',
                  formProperty: 'nombre',
                  formValues: formValues,
                  textCapitalization: TextCapitalization.words,
                  controller: _nombreController,
                  validator: (value) => RegexConst.validarNombre(value),
                ),
      
                const SizedBox(height: 15,),
                
                CustomInputTextField(
                  hintText: 'Apellido Paterno',
                  formProperty: 'apellido_paterno',
                  formValues: formValues,
                  textCapitalization: TextCapitalization.words,
                  controller: _apePaternoController,
                  validator: (value) => RegexConst.validarApellidoPat(value),
                ),
                
                const SizedBox(height: 15,),
      
                CustomInputTextField(
                  hintText: 'Apellido Materno (opcional)',
                  formProperty: 'apellido_materno',
                  formValues: formValues,
                  textCapitalization: TextCapitalization.words,
                  controller: _apeMaternoController,
                  validator: (value) => RegexConst.validarApellidoMat(value),
                ),
                
                const SizedBox(height: 15,),
      
                CustomInputTextField(
                  hintText: 'Correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  formProperty: 'correo',
                  formValues: formValues,
                  controller: _emailController,
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
    
                CustomInputTextField(
                  hintText: 'Confirmación de Contraseña',
                  obscureText: true,
                  formProperty: 'password_check',
                  formValues: formValues,
                  controller: _confirmPasswordController,
                  validator: (value) => RegexConst.validarContrasena(value),
                ),
    
                const SizedBox(height: 40,),
    
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: ElevatedButton(
                    
                    onPressed: () async {
                      // Al presionar guardar, se esconde el teclado
                      FocusScope.of(context).requestFocus(FocusNode()); 
                      print(formValues);
                      if(!myFormKey.currentState!.validate()){
                      //   print('Formulario no valido');
                        return;
                      }

                      registrarAlumno();
    
                    },
                    child: const Text('Registrar', style: TextStyle(fontSize: 20),),
                  ),
                ),

                const SizedBox(height: 40),

                const _CuentaExistente(),
              ],
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
          '¿Ya tienes una cuenta?',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, 'loginScreen'),
          child: Text(
            'Inicia sesión',
            style: GoogleFonts.inter(
              color: Colors.lightBlueAccent
            ),
          ),
        ),
      ],
    );
  }
}