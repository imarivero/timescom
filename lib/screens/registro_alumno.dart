import 'package:flutter/material.dart';
import 'package:timescom/widgets/custom_input_field.dart';

class RegistroAlumnoScreen extends StatelessWidget {
   
  const RegistroAlumnoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> myFormKey = GlobalKey();

    final Map<String, String> formValues = {
      'nombre': 'Omar Imanol',
      'apellido_paterno' : 'Rivero',
      'apellido_materno' : 'Ronquillo',
      'email'     : 'imarivero@outlook.com',
      'password'  : '123',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: myFormKey,
            child: Column(
              children: [
                
                CustomInputField(
                  labelText: 'Nombre(s)',
                  helperText: 'Ingresa tu nombre',
                  formProperty: 'nombre',
                  formValues: formValues,
                ),

                const SizedBox(height: 15,),
                
                CustomInputField(
                  labelText: 'Apellido Paterno',
                  helperText: 'Ingresa tu apellido paterno',
                  formProperty: 'apellido_paterno',
                  formValues: formValues,
                ),
                
                const SizedBox(height: 15,),

                CustomInputField(
                  labelText: 'Apellido Materno (opcional)',
                  helperText: 'Ingresa tu apellido materno',
                  formProperty: 'apellido_materno',
                  formValues: formValues,
                ),
                
                const SizedBox(height: 15,),

                CustomInputField(
                  labelText: 'Correo electrónico',
                  helperText: 'Ingresa tu correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  formProperty: 'email',
                  formValues: formValues,
                ),

                const SizedBox(height: 15,),

                CustomInputField(
                    labelText: 'Contraseña',
                    helperText: 'Ingresa tu contraseña',
                    obscureText: true,
                    formProperty: 'password',
                    formValues: formValues,
                  ),

                  const SizedBox(height: 15,),

                  CustomInputField(
                    labelText: 'Confirmación de Contraseña',
                    helperText: 'Ingresa nuevamente tu contraseña',
                    obscureText: true,
                    formProperty: 'password_check',
                    formValues: formValues,
                  ),

                  const SizedBox(height: 20,),

                  ElevatedButton(
                    onPressed: () {
                      // Al presionar guardar, se esconde el teclado
                      FocusScope.of(context).requestFocus(FocusNode()); 

                      if(!myFormKey.currentState!.validate()){
                        print('Formulario no valido');
                        return;
                      }

                      print(formValues);
                    },
                    child: const SizedBox(
                      child: Center(child: Text('Regístrate')),
                    )
                  )
              ],
            ),
          ),
        ),
      )
    );
  }
}