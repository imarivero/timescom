import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/widgets/card_row.dart';
import 'package:timescom/widgets/card_table.dart';
import 'package:timescom/widgets/custom_floating_buttons.dart';
import 'package:timescom/widgets/custom_navbar.dart';

class MainMatrizScreen extends StatefulWidget {
   
  const MainMatrizScreen({Key? key}) : super(key: key);

  @override
  State<MainMatrizScreen> createState() => _MainMatrizScreenState();
}

class _MainMatrizScreenState extends State<MainMatrizScreen> with SingleTickerProviderStateMixin{

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 260),
  );

  late final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
  
  late final Animation<double> _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  
  @override
  void initState(){
    super.initState();
  }
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
            Text('Hola, \n <<Nombre del alumno>>', style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)),
          
            // Tarjetas actividades y habitos
            const CardRow(),
          
            // Texto y matriz
            const CardTable(),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButtons(animation: _animation, animationController: _animationController,),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}