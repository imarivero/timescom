import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/providers/auth_provider.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';

class RestaurarPasswordScreen extends StatefulWidget {
   
  const RestaurarPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RestaurarPasswordScreen> createState() => _RestaurarPasswordScreenState();
}

class _RestaurarPasswordScreenState extends State<RestaurarPasswordScreen> {
  // TextControllers
  final _emailController = TextEditingController();

  // Manejo de llaves de formulario
  final GlobalKey<FormState> _myFormKey = GlobalKey();

  // Future restaurarContrasena() async{
  //   try{
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
  //     showMessage('¡El correo ha sido enviado! Asegurate de revisar la carpeta spam.');
  //   } on FirebaseAuthException catch(e){
  //     if(e.code == 'user-not-found'){
  //       showMessage('El correo ingresado no esta registrado');
  //     } else{
  //       showMessage('Lo sentimos, ha ocurrido un error. Vuelve a intentarlo mas tarde.');
  //     }
  //   }
  // }

  //   // Mensaje de error general para cualquier codigo devuelto
  // void showMessage(String mensaje) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.grey.shade800,
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //         title: Center(
  //           child: Text(
  //             mensaje,
  //             // 'Lo sentimos, ha habido un error, vuelve a intentarlo mas tarde',
  //             style: GoogleFonts.inter(
  //               color: Colors.white
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         content: ElevatedButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Aceptar', style: TextStyle(fontSize: 20),)
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {

    final Map<String, String> formValues = {
      'email'     : 'ima@outlook.com',
    };

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _myFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),

                  Text('Restaurar contraseña', 
                    style: GoogleFonts.inter(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.center,
                  ),
          
                  const SizedBox(height: 70,),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'No te preocupes, ingresa tu correo y nosotros te enviaremos un link donde podrás restaurar tu contraseña.', 
                      style: GoogleFonts.inter(
                      fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
          
                  const SizedBox(height: 50,),
              
                  CustomInputTextField(
                    hintText: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    formProperty: 'correo',
                    formValues: formValues,
                    controller: _emailController,
                    validator: (value) => RegexConst.validarCorreo(value),
                  ),

                  const SizedBox(height: 20,),
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        if(!_myFormKey.currentState!.validate()){
                          // print('form invalido');
                          return;
                        }
                        // restaurarContrasena();
                        authProvider.restaurarContrasena(_emailController.text, context);

                      },
                      child: const Text('Enviar Correo', style: TextStyle(fontSize: 18),),
                    ),
                  ),
        
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}