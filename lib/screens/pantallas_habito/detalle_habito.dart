import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:timescom/models/habito.dart';
import 'package:timescom/providers/habit_provider.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/widgets.dart';

class DetalleHabito extends StatelessWidget {

  const DetalleHabito({super.key});

  @override
  Widget build(BuildContext context) {

    final Habito habito = ModalRoute.of(context)!.settings.arguments as Habito;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _Controles(habito: habito,),

            Center(
              child: Text('Hábito', 
                style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 10,),

            _Body(habito: habito,),

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

class _Body extends StatelessWidget {

  final Habito habito;
  const _Body({
    super.key,
    required this.habito
  });

  @override
  Widget build(BuildContext context) {

    bool banderaDiasActivos = false;

    for (bool activo in habito.diasRepeticion.values) {
      if(activo != false){ 
        // Hay por lo menos uno activo
        banderaDiasActivos = true;
        break;
      }
    }
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Título:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
    
          Text(habito.titulo, style: GoogleFonts.inter(fontSize: 20),),
          const SizedBox(height: 30,),

          // Bloque descripcion
          if(habito.descripcion != null && habito.descripcion != '')
            Text('Descripción:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
          if(habito.descripcion != null && habito.descripcion != '')
            const SizedBox(height: 10,),
          if(habito.descripcion != null && habito.descripcion != '')
            Text(habito.descripcion!, style: GoogleFonts.inter(fontSize: 20)),
          if(habito.descripcion != null && habito.descripcion != '')
            const SizedBox(height: 30,),
          
          // Fecha limite
          if(habito.hora != null && habito.hora != '')
            Text('Hora:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
          if(habito.hora != null && habito.hora != '')
            const SizedBox(height: 10,),
          if(habito.hora != null && habito.hora != '')
            Text(habito.hora!, style: GoogleFonts.inter(fontSize: 20)),
          if(habito.hora != null && habito.hora != '')
            const SizedBox(height: 30,),
    
          if(banderaDiasActivos)
            Text('Dias de repetición:', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          if(banderaDiasActivos)
            RowDias(diasRepeticion: habito.diasRepeticion,),
          if(banderaDiasActivos)
            const SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class RowDias extends StatelessWidget {

  final Map<String, bool> diasRepeticion;

  const RowDias({
    Key? key, required this.diasRepeticion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          _esferaDia('Lu', diasRepeticion['Lu']!),
          _esferaDia('Ma', diasRepeticion['Ma']!),
          _esferaDia('Mi', diasRepeticion['Mi']!),
          _esferaDia('Ju', diasRepeticion['Ju']!),
          _esferaDia('Vi', diasRepeticion['Vi']!),
          _esferaDia('Sa', diasRepeticion['Sa']!),
          _esferaDia('Do', diasRepeticion['Do']!),
        ],
      ),
    );
  }

  Padding _esferaDia(String dia, bool activo) {

    Color color = Colors.blue;

    if(!activo){
      color = Colors.grey.shade900;
    }
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(), 
          backgroundColor: color
        ),
        child: Text(
          dia,
          style: const TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}

class _Controles extends StatefulWidget {

  final Habito habito;

  const _Controles({super.key, required this.habito});

  @override
  State<_Controles> createState() => _ControlesState();
}

class _ControlesState extends State<_Controles> {

  Future<void> eliminarHabito(HabitProvider taskProvider, Habito habito) async{

    bool exito = await taskProvider.eliminarHabito(habito);

    if(!mounted) return;
    if(exito){await PopMessage.message('El habito ha sido eliminado!', context);}

    if(!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final habitProvider = Provider.of<HabitProvider>(context);

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
              onPressed: () => Navigator.pushNamed(context, 'modificarHabito', arguments: widget.habito),
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () async{

                bool confim = await PopMessage.confirmacion('¿Estas segur@ que deseas eliminar este hábito?', context);
                if(confim){
                  await eliminarHabito(habitProvider, widget.habito);
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