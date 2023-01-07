import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/models/alumno.dart';
import 'package:timescom/providers/providers.dart';
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
    'ultimo_login' : DateTime.now().toString(),
  };

  Future registrarAlumno(
    AuthProvider authProvider, 
    AlumnoProvider alumnoProvider, 
    TaskProvider taskProvider,
    HabitProvider habitProvider,
    RegistrosProvider registrosProvider) async{

    // Verifica si las contrasenas ingresadas son iguales
    if(confirmacionPassword()){

      // // Carga mientras se resuelve el Future
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );

      // Remover contrasenas del mapeo
      formValues.remove('password');
      formValues.remove('password_check');

      Alumno? alumno = await authProvider.emailUserSignUp(
        _emailController.text,
        _passwordController.text,
        context
      );

      if(alumno != null){
        formValues['id_alumno'] = alumno.uid;
        await alumnoProvider.addAlumnoInfo(alumno, formValues);
        await alumnoProvider.getAlumnoInfo(alumno);
        taskProvider.setIdAlumno = alumno.uid;
        habitProvider.setIdAlumno = alumno.uid;
        registrosProvider.setIdAlumno = alumno.uid;

        // Llama al wrapper
        if(!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, 'wrapper', (route) => false);
      }

      
      // Hace pop a la pantalla de carga
      // Navigator.pop(context);

    } else{
      authProvider.errorMessage('Error: Las contraseñas no son iguales, por favor, verifica tus datos', context);
    }
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
    
    final authProvider = Provider.of<AuthProvider>(context);
    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final habitProvider = Provider.of<HabitProvider>(context);
    final registrosProvider = Provider.of<RegistrosProvider>(context);

    // final _alumno = Alumno();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      maxLines: 1,
                      controller: _passwordController,
                      validator: (value) => RegexConst.validarContrasena(value),
                    ),
              
                  const SizedBox(height: 15,),
            
                  CustomInputTextField(
                    hintText: 'Confirmación de Contraseña',
                    obscureText: true,
                    formProperty: 'password_check',
                    formValues: formValues,
                    maxLines: 1,
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
        
                        if(!myFormKey.currentState!.validate()){
                        //   print('Formulario no valido');
                          return;
                        }
        
                        registrarAlumno(
                          authProvider,
                          alumnoProvider,
                          taskProvider,
                          habitProvider,
                          registrosProvider,
                        );
            
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