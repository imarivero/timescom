import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardRow extends StatelessWidget {
  const CardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _SingleCard(titulo: 'Actividades', descripcion: 'Todas tus actividades',),
          _SingleCard(titulo: 'Hábitos', descripcion: 'Todos tus hábitos',)
        ],
      ),
    );
  }
}

class _SingleCard extends StatelessWidget {
  final String titulo;
  final String descripcion;

  const _SingleCard({
    super.key,
    required this.titulo, 
    required this.descripcion
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,
      width: 170, // TODO: revisar expansion de pixeles de pantalla
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(titulo, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            Text(descripcion, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}