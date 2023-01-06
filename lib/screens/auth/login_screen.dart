import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/models/alumno.dart';
import 'package:timescom/providers/providers.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';

class LoginScreen extends StatefulWidget {
   
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // TextControllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Manejo de llaves de formulario
  final GlobalKey<FormState> _myFormKey = GlobalKey();

  Future iniciarSesion(
    AuthProvider authProvider, 
    AlumnoProvider alumnoProvider,
    TaskProvider taskProvider,
    HabitProvider habitProvider,
    RegistrosProvider registrosProvider) async{
    // Carga mientras se resuelve el Future
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    Alumno? alumno = await authProvider.emailUserLogin(
      _emailController.text, 
      _passwordController.text, 
      context
    );

    if(alumno != null){
      await alumnoProvider.getAlumnoInfo(alumno);
      await taskProvider.getActividades(alumno.uid);
      await habitProvider.getHabitos(alumno.uid);
      await registrosProvider.getRegistros(alumno.uid);
      
      if(!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, 'wrapper', (route) => false);
    } 
  }

  @override
  Widget build(BuildContext context) {

    // final _alumno = Alumno();
    final authProvider = Provider.of<AuthProvider>(context);
    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final habitProvider = Provider.of<HabitProvider>(context);
    final registrosProvider = Provider.of<RegistrosProvider>(context);

    final Map<String, String> formValues = {
      'nombre': 'Omar Imanol',
      'apellido_paterno' : 'Rivero',
      'apellido_materno' : 'Ronquillo',
      'correo'     : 'imarivero@outlook.com',
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
                    validator: (value) => RegexConst.validarCorreo(value),
                  ),
              
                  const SizedBox(height: 15,),
            
                  CustomInputTextField(
                    hintText: 'Contraseña',
                    obscureText: true,
                    formProperty: 'password',
                    formValues: formValues,
                    controller: _passwordController,
                    maxLines: 1,
                    validator: (value) => RegexConst.validarContrasena(value),
                  ),
            
                  const SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, 'restaurarPasswordScreen'),
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: GoogleFonts.inter(
                          color: Colors.lightBlueAccent
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
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
                        iniciarSesion(
                          authProvider,
                          alumnoProvider,
                          taskProvider,
                          habitProvider,
                          registrosProvider,
                        );
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