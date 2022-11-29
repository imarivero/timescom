
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/models/actividad.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/custom_navbar.dart';

class DetalleActividadScreen extends StatelessWidget {
   
  const DetalleActividadScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Actividad actividad = ModalRoute.of(context)!.settings.arguments as Actividad;

    // Actividad actividad = Actividad(titulo: 'Título', prioridad: 1);
    actividad.descripcion = 'Descripción';
    actividad.fechaLim = DateTime.now();
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Icon(Icons.arrow_back_ios_new),
            ),

            Center(
              child: Text('Actividad', 
                style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 40,),

            _Descripcion(actividad: actividad,),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.edit_note),
      ),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

class _Descripcion extends StatelessWidget {
  const _Descripcion({
    Key? key,
    required this.actividad,
  }) : super(key: key);

  final Actividad actividad;

  @override
  Widget build(BuildContext context) {

    String prioridadText = '';
    switch (actividad.prioridad) {
      case 1:
        prioridadText = 'Importante + Urgente';
        break;
      case 2:
        prioridadText = 'Importante + No Urgente';
        break;
      case 3:
        prioridadText = 'No Importante + Urgente';
        break;
      case 4:
        prioridadText = 'No Importante + No Urgente';
        break;
      default:
        prioridadText = 'Error';
        break;
    }

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(actividad.titulo, style: GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.bold),),
          const SizedBox(height: 30,),
          if(actividad.descripcion != null)
            Text(actividad.descripcion!, style: GoogleFonts.inter(fontSize: 20)),
          const SizedBox(height: 30,),
          if(actividad.fechaLim != null)
            Text('Fecha: ${formatter.format(actividad.fechaLim!)}', style: GoogleFonts.inter(fontSize: 20)),
          const SizedBox(height: 30,),
          Text('Prioridad: $prioridadText', style: GoogleFonts.inter(fontSize: 20))
        ],
      ),
    );
  }
}