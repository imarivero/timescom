import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/models/categoria.dart';

class CardRow extends StatelessWidget {
  const CardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'categoriaActividad', arguments: Categoria(titulo: 'todas', descripcion: 'Todas tus actividades')),
            child: _SingleCard(
              titulo: 'Actividades', 
              descripcion: 'Todas tus actividades', 
              categoria: Categoria(titulo: 'todas', descripcion: 'Todas tus Actividades'),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'categoriaHabito'),
            child: _SingleCard(
              titulo: 'Hábitos', 
              descripcion: 'Todos tus hábitos', 
              categoria: Categoria(titulo: 'habitos', descripcion: 'Todos tus hábitos')
            ),
          )
        ],
      ),
    );
  }
}

class _SingleCard extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final Categoria categoria;

  const _SingleCard({
    required this.titulo, 
    required this.descripcion,
    required this.categoria
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.all(10),
      // TODO: Revisar otros tamanos 
      height: height/8.5,
      width: width/2.3,
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