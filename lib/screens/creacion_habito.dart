import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/widgets/custom_navbar.dart';

class CreacionHabitoScreen extends StatelessWidget {
   
  const CreacionHabitoScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
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
              child: Text('Registro de hábito', 
                style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 40,),

          

          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}