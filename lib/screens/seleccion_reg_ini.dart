import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeleccionRegIniScreen extends StatelessWidget {
   
  const SeleccionRegIniScreen({Key? key}) : super(key: key);
  
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Center(
              child: Image(
                image: AssetImage('assets/logo.png'), //399 × 336
                width: 309,
                height: 246,
              ),
              
            ),

            const SizedBox(height: 50,),


            Center(
              child: Text('La única aplicación de productividad que tú necesitas', 
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
              ),
            ),

    
            const SizedBox(height: 60,),
    
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'loginScreen');
              },
              child: const Text('Iniciar Sesión', style: TextStyle(fontSize: 20),),
            ),

            const SizedBox(height: 30,),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'registroScreen');
              },
              child: const Text('Registrarse', style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}