import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/widgets/card_row.dart';
import 'package:timescom/widgets/card_table.dart';
import 'package:timescom/widgets/custom_navbar.dart';

class MainMatrizScreen extends StatelessWidget {
   
  const MainMatrizScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            
            // Menu control y texto
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, color: Colors.white, size: 30,),
                Text('Inicio', style: GoogleFonts.inter(fontSize: 15,),)
              ],
            ),

            // Saludo y nombre de alumno
            const SizedBox(height: 20,),
            Text('Hola \n <<Nombre del alumno>>', style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)),

            // Tarjetas actividades y habitos
            CardRow(),
    
            // Texto y matriz
            CardTable(),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: CustomFloatingButton(),
    );
  }
}