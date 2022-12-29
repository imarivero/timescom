import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/providers/auth_provider.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';

class CambiarPassword extends StatefulWidget {
   
  const CambiarPassword({Key? key}) : super(key: key);

  @override
  State<CambiarPassword> createState() => _CambiarPasswordState();
}

class _CambiarPasswordState extends State<CambiarPassword> {
  // TextControllers
  final _passwordController = TextEditingController();

  // Manejo de llaves de formulario
  final GlobalKey<FormState> _myFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final Map<String, String> formValues = {
      'password'     : '123456',
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

                  Text('Cambiar contraseña', 
                    style: GoogleFonts.inter(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.center,
                  ),
          
                  const SizedBox(height: 70,),
                  
                  Center(
                    child: Text(
                      'Ingresa tu nueva contraseña', 
                      style: GoogleFonts.inter(
                      fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
          
                  const SizedBox(height: 20,),
              
                  CustomInputTextField(
                    hintText: 'Contraseña',
                    keyboardType: TextInputType.text,
                    formProperty: 'password',
                    formValues: formValues,
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) => RegexConst.validarContrasena(value),
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
                        authProvider.actualizarPassword(_passwordController.text, context);
                      },
                      child: const Text('Guardar', style: TextStyle(fontSize: 18),),
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