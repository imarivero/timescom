import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/providers/providers.dart';
import 'package:timescom/widgets/widgets.dart';

class CredentialsInput{

  static eliminarCuenta(AlumnoProvider alumnoProvider, AuthProvider authProvider, BuildContext context) async{

    // Carga mientras se resuelve el Future
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await alumnoProvider.eliminarDatosAlumno(alumnoProvider.alumno!);
    await authProvider.eliminarCuenta(context);
  }

  static Future<void> showInputDialog(BuildContext context, String sigPantalla) async{

    final Map<String, String> formMap = {};
    bool validacion = false;

    final _passwordController = TextEditingController();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final alumnoProvider = Provider.of<AlumnoProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    final registrosProvider = Provider.of<RegistrosProvider>(context, listen: false);
    
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.warning),
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // icon: error == false ? const Icon(Icons.check) : const Icon(Icons.error),
          title: Center(
            child: Text(
              'Para hacer cambios a tu cuenta, primero debes volver a ingresar tu contraseña',
              style: GoogleFonts.inter(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: CustomInputTextField(
            hintText: 'Contraseña',
            formProperty: 'password',
            formValues: formMap,
            maxLines: 1,
            controller: _passwordController,
            obscureText: true,
            validator: (value) => RegexConst.validarContrasena(value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(fontSize: 20),)
            ),

            TextButton(
              onPressed: () async{
                int count = 0;
                validacion = await authProvider.reAuthAlumno(context, _passwordController.text);

                if(validacion && sigPantalla == 'eliminacion'){
                  
                  await Future.delayed(const Duration(seconds: 1));

                  // TODO: Corregir llamadas al contexto
                  // await eliminarCuenta(alumnoProvider, authProvider, context);

                  // Debido a las reglas de seguridad especificadas en firestore, deben eliminarse
                  // primero los registros y al final cerrar y borrar al usuario de auth service
                  await taskProvider.borrarTodo();
                  await habitProvider.borrarTodo();
                  await registrosProvider.borrarTodo();

                  await alumnoProvider.eliminarDatosAlumno(alumnoProvider.alumno!);
                  await authProvider.eliminarCuenta(context);

                  Navigator.pushNamedAndRemoveUntil(context, 'wrapper', (route) => false);
                  
                }else if(validacion){
                  await Future.delayed(const Duration(seconds: 2));
                  // Hace pop a la pantalla de confirmacion y luego a la de input de credenciales
                  Navigator.popUntil(context, (_) => count++ >= 2);
                  await Navigator.pushNamed(context, sigPantalla);
                }
              },
              child: const Text('Continuar', style: TextStyle(fontSize: 20, color: Colors.red),)
            ),
          ],
        );
      },
    );
  }
}
