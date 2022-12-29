import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/auth_provider.dart';
import 'package:timescom/widgets/credentials_input.dart';


class InfoPerfil extends StatelessWidget {
  const InfoPerfil({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
        
                const Center(child: _Body()),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _Body extends StatelessWidget {

  const _Body({
    Key? key,
  }) : super(key: key);

  eliminarCuenta(AlumnoProvider alumnoProvider, AuthProvider authProvider, BuildContext context) async{

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

    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, 'wrapper', (route) => false);
  }


  @override
  Widget build(BuildContext context) {

    final alumnoProvider = Provider.of<AlumnoProvider>(context);

    return Column(
      children: [
        Text('Perfil', 
          style: GoogleFonts.inter(
          fontSize: 38,
          fontWeight: FontWeight.bold,),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30,),

        const Icon(
          Icons.person,
          color: Colors.white,
          size: 90,
        ),

        const SizedBox(height: 30,),

        Text(
          '${alumnoProvider.alumno!.nombre} ${alumnoProvider.alumno!.apellidoPaterno} ${alumnoProvider.alumno!.apellidoMaterno}', 
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 10,),

        Text(
          alumnoProvider.alumno!.correo, 
          style: GoogleFonts.inter(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 30,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          child: ElevatedButton(
            onPressed: () async{
              await CredentialsInput.showInputDialog(context, 'modificarDatosAlumno');
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text('Modificar Datos', style: TextStyle(fontSize: 20),),
          ),
        ),
        
        const SizedBox(height: 20,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          child: ElevatedButton(
            onPressed: () async {
              await CredentialsInput.showInputDialog(context, 'modificarPassword');
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: const Text('Cambiar Contraseña', style: TextStyle(fontSize: 20),),
          ),
        ),
        
        const SizedBox(height: 150,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          child: ElevatedButton(
            onPressed: () async {
              await CredentialsInput.showInputDialog(context, 'eliminacion');
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: const Text('Eliminar Cuenta', style: TextStyle(fontSize: 20),),
          ),
        ),
      ],
    );
  }
}