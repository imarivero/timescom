import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
   
  const WelcomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(child: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Center(
              child: Text('Bienvenid@', 
               style: GoogleFonts.inter(
                fontSize: 38,
                fontWeight: FontWeight.bold,)
              ),
            ),

            const SizedBox(height: 200,),


            Center(
              child: Text('Gracias por descargar esta aplicación esperamos que te sea de mucha utilidad!', 
                style: GoogleFonts.inter(
                  fontSize: 25,),
                textAlign: TextAlign.center,
              ),
              
            ),

    
            const SizedBox(height: 40,),
    
            ElevatedButton(
              
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'seleccionRegIniScreen');
              },
              child: const Text('Aceptar', style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}