import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/auth_provider.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';

class ModificarDatos extends StatefulWidget {
   
  const ModificarDatos({Key? key}) : super(key: key);

  @override
  State<ModificarDatos> createState() => _ModificarDatosState();
}

class _ModificarDatosState extends State<ModificarDatos> {

  // TextControllers
  final _nombreController = TextEditingController();
  final _apePaternoController = TextEditingController();
  final _apeMaternoController = TextEditingController();
  final _emailController = TextEditingController();

  final Map<String, String> formValues = {};

  Future actualizarInformacion(AuthProvider authProvider, AlumnoProvider alumnoProvider) async{

    // Saca del mapa los valores no modificados
    formValues.forEach((key, value) {
      if(value == ''){
        formValues.remove(key);
      }
    });

    // Si tambien cambio el correo, este debe modificarse en el servicio de autenticacion
    if(formValues['correo'] != '' && formValues['correo'] != null){
      
      await authProvider.actualizarCorreo(formValues['correo']!);
    }

    if(alumnoProvider.alumno != null){
      await alumnoProvider.actualizarAlumnoInfo(formValues);
    }

    if(!mounted) return;
    await authProvider.errorMessage('Tus datos se han modificado exitosamente!', context);

    if(!mounted) return;
    Navigator.pop(context);
  }

  bool realizoCambios(){
    bool bandera = false;
    formValues.forEach((key, value) {
      if(value != ''){
        bandera = true;
        return; // rompe el ciclo
      }
    });
    return bandera;
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> myFormKey = GlobalKey();
    
    final authProvider = Provider.of<AuthProvider>(context);
    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    // final _alumno = Alumno();

    String apellidoMaterno = '';

    if(alumnoProvider.alumno!.apellidoMaterno == ''){
      apellidoMaterno = 'Apellido Materno (opcional)';
    } else {
      apellidoMaterno = alumnoProvider.alumno!.apellidoMaterno;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: myFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
        
                  Center(
                    child: Text('Modificar Información', 
                      style: GoogleFonts.inter(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,),
                      textAlign: TextAlign.center,
                    ),
                  ),
        
                  const SizedBox(height: 30,),
        
                  CustomInputTextField(
                    hintText: alumnoProvider.alumno!.nombre,
                    formProperty: 'nombre',
                    formValues: formValues,
                    textCapitalization: TextCapitalization.words,
                    controller: _nombreController,
                    validator: (value) => RegexConst.validarApellidoMat(value),
                  ),
              
                  const SizedBox(height: 15,),
                  
                  CustomInputTextField(
                    hintText: alumnoProvider.alumno!.apellidoPaterno,
                    formProperty: 'apellido_paterno',
                    formValues: formValues,
                    textCapitalization: TextCapitalization.words,
                    controller: _apePaternoController,
                    validator: (value) => RegexConst.validarApellidoMat(value),
                  ),
                  
                  const SizedBox(height: 15,),
              
                  CustomInputTextField(
                    hintText: apellidoMaterno,
                    formProperty: 'apellido_materno',
                    formValues: formValues,
                    textCapitalization: TextCapitalization.words,
                    controller: _apeMaternoController,
                    validator: (value) => RegexConst.validarApellidoMat(value),
                  ),
                  
                  const SizedBox(height: 15,),
              
                  CustomInputTextField(
                    hintText: alumnoProvider.alumno!.correo,
                    keyboardType: TextInputType.emailAddress,
                    formProperty: 'correo',
                    formValues: formValues,
                    controller: _emailController,
                    validator: (value) => RegexConst.validarCorreoActualizado(value),
                  ),
              
                  const SizedBox(height: 40,),
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 3),
                    child: ElevatedButton(
                      
                      onPressed: () async {
                        
                        // Al presionar guardar, se esconde el teclado
                        FocusScope.of(context).requestFocus(FocusNode()); 
        
                        if(!myFormKey.currentState!.validate()){
                        //   print('Formulario no valido');
                          return;
                        }

                        if(realizoCambios()){
                          actualizarInformacion(authProvider, alumnoProvider);
                        } else{
                          authProvider.errorMessage('No realizaste ningun cambio.', context);
                        }
                      },
                      child: const Text('Guardar', style: TextStyle(fontSize: 20),),
                    ),
                  ),
        
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}