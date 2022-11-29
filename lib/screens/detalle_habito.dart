import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:timescom/models/habito.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/custom_navbar.dart';

class DetalleHabito extends StatelessWidget {
  const DetalleHabito({super.key});

  @override
  Widget build(BuildContext context) {

    final Habito habito = ModalRoute.of(context)!.settings.arguments as Habito;
    habito.hora = DateTime.now();
    habito.descripcion = 'Descripcion habito';
    
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
              child: Text('Hábito', 
                style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 40,),

            _Descripcion(habito: habito,),

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

  final Habito habito;
  const _Descripcion({
    super.key,
    required this.habito
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('HH:mm');
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(habito.titulo, style: GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.bold),),
          const SizedBox(height: 30,),
          if(habito.descripcion != null)
            Text(habito.descripcion!, style: GoogleFonts.inter(fontSize: 20)),
          const SizedBox(height: 30,),
          if(habito.hora != null)
            Text('Hora: ${format.format(habito.hora!)}', style: GoogleFonts.inter(fontSize: 20)),
          const SizedBox(height: 30,),
          // TODO: Construir burbujas
        ],
      ),
    );
  }
}