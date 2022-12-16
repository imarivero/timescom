import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:timescom/models/alumno.dart';
import 'package:timescom/providers/register_form_provider.dart';
import 'package:timescom/services/auth_service.dart';
import 'package:timescom/widgets/custom_input_email.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';

import '../services/notificacions_services.dart';

class RegistroAlumnoScreen extends StatelessWidget {
  const RegistroAlumnoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registroForm = Provider.of<RegisterFormProvider>(context);
    final _alumno = Alumno();

    final Map<String, String> formValues = {
      'nombre': 'Omar Imanol',
      'apellido_paterno': 'Rivero',
      'apellido_materno': 'Ronquillo',
      'email': 'imarivero@outlook.com',
      'password': '123',
    };

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: registroForm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text('Registro',
                      style: GoogleFonts.inter(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                // CustomInputTextField(
                //   hintText: 'Nombre(s)',
                //   formProperty: 'nombre',
                //   formValues: formValues,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // CustomInputTextField(
                //   hintText: 'Apellido Paterno',
                //   formProperty: 'apellidoPaterno',
                //   formValues: formValues,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // CustomInputTextField(
                //   hintText: 'Apellido Materno (opcional)',
                //   formProperty: 'apellidoMaterno',
                //   formValues: formValues,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                CustomInputTextFieldemail(
                  hintText: 'Correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  formProperty: 'correo',
                  formValues: formValues,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomInputTextField(
                  hintText: 'Contraseña',
                  obscureText: true,
                  formProperty: 'password',
                  formValues: formValues,
                ),
                const SizedBox(
                  height: 15,
                ),
                // CustomInputTextField(
                //   hintText: 'Confirmación de Contraseña',
                //   obscureText: true,
                //   formProperty: 'password_check',
                //   formValues: formValues,
                // ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: ElevatedButton(
                    onPressed: () async {
                      final authservice =
                          Provider.of<AuthService>(context, listen: false);

                      final String? errorMessage =
                          await authservice.crearUsuario(
                              registroForm.email, registroForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(
                            context, 'mainMatrizScreen');
                      } else {
                        print(errorMessage);
                        NotificationService.showSnackBar(errorMessage);
                      }

                      FocusScope.of(context).requestFocus(FocusNode());

                      // QuickAlert.show(
                      //   context: context,
                      //   title: 'Registro exitoso',
                      //   type: QuickAlertType.success,
                      //   text:
                      //       'Ya solo debes iniciar sesion con tu nueva cuenta 😎',
                      //   confirmBtnText: 'Continuar',
                      // );
                    },
                    child: const Text(
                      'Registrar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
