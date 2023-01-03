import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopMessage{
  // Mensaje de error general para cualquier codigo devuelto
  static message(String mensaje, BuildContext context, {bool error = true}) async{
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: error == false ? const Icon(Icons.check) : const Icon(Icons.error),
          title: Center(
            child: Text(
              mensaje,
              // 'Lo sentimos, ha habido un error, vuelve a intentarlo mas tarde',
              style: GoogleFonts.inter(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar', style: TextStyle(fontSize: 20),)
          ),
        );
      },
    );
  }
  
  static messageSinBoton(String mensaje, BuildContext context, {bool exito = true, bool dismissable = false}) async{
    await showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: exito == true ? const Icon(Icons.check) : const Icon(Icons.error),
          title: Center(
            child: Text(
              mensaje,
              // 'Lo sentimos, ha habido un error, vuelve a intentarlo mas tarde',
              style: GoogleFonts.inter(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
  
  static Future<bool> confirmacion(String mensaje, BuildContext context) async{

    bool bandera = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: const Icon(Icons.warning, color: Colors.amber,),
          title: Center(
            child: Text(
              mensaje,
              style: GoogleFonts.inter(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                bandera = true;
              },
              child: const Text('Aceptar', style: TextStyle(fontSize: 20, color: Colors.red),)
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(fontSize: 20))
            ),
          ],
        );
      },
    );
    return bandera;
  }
}