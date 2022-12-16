import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('Bienvenid@',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                height: 300,
                child: SvgPicture.asset('assets/svgs/slide-1.svg'),
              ),
              Center(
                child: Text(
                  'Gracias por descargar esta aplicación esperamos que te sea de mucha utilidad!',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'seleccionRegIniScreen');
                },
                child: const Text(
                  'Aceptar',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
