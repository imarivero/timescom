import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/models/actividad.dart';
import 'package:timescom/providers/providers.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/widgets.dart';

class DetalleActividadScreen extends StatelessWidget{

  const DetalleActividadScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Actividad actividad = ModalRoute.of(context)!.settings.arguments as Actividad;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _Controles(actividad: actividad,),

            Center(
              child: Text('Actividad', 
                style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 10,),

            _Body(actividad: actividad,),

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

class _Controles extends StatefulWidget {

  final Actividad actividad;

  const _Controles({super.key, required this.actividad});

  @override
  State<_Controles> createState() => _ControlesState();
}

class _ControlesState extends State<_Controles> {

  Future<void> eliminarActividad(TaskProvider taskProvider, Actividad actividad) async{

    bool exito = await taskProvider.eliminarActividad(actividad);

    if(!mounted) return;
    if(exito){await PopMessage.message('La actividad ha sido eliminada!', context);}

    if(!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final taskProvider = Provider.of<TaskProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, 'modificarActividad', arguments: widget.actividad),
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () async{

                bool confim = await PopMessage.confirmacion('¿Estas segur@ que deseas eliminar esta actividad?', context);
                if(confim){
                  await eliminarActividad(taskProvider, widget.actividad);
                }

              },
              child: const Icon(Icons.delete_rounded, color: Colors.red,),
            ),
          ],
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.actividad,
  }) : super(key: key);

  final Actividad actividad;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
      
            Text('Título:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
      
            Text(actividad.titulo, style: GoogleFonts.inter(fontSize: 20),),
            const SizedBox(height: 30,),

            // Bloque descripcion
            if(actividad.descripcion != null && actividad.descripcion != '')
              Text('Descripción:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
            if(actividad.descripcion != null && actividad.descripcion != '')
              const SizedBox(height: 10,),
            if(actividad.descripcion != null && actividad.descripcion != '')
              Text(actividad.descripcion!, style: GoogleFonts.inter(fontSize: 20)),
            if(actividad.descripcion != null && actividad.descripcion != '')
              const SizedBox(height: 30,),
            
            // Fecha limite
            if(actividad.fechaLim != null && actividad.fechaLim != '')
              Text('Fecha límite:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
            if(actividad.fechaLim != null && actividad.fechaLim != '')
              const SizedBox(height: 10,),
            if(actividad.fechaLim != null && actividad.fechaLim != '')
              Text(actividad.fechaLim!, style: GoogleFonts.inter(fontSize: 20)),
            if(actividad.fechaLim != null && actividad.fechaLim != '')
              const SizedBox(height: 30,),
      
      
            Text('Prioridad asignada:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
             const SizedBox(height: 10,),
            Text(actividad.prioridad, style: GoogleFonts.inter(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
