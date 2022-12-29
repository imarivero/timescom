import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/models/categoria.dart';

class CardTable extends StatelessWidget {
  const CardTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Matriz de prioridad', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),),
        Table(
          children:  [
            TableRow(
              children: [
                  _SingleCard(
                  titulo: 'Urgente + Importante', 
                  numero: 10, 
                  icon: FontAwesomeIcons.exclamation,
                  color: Colors.red,
                  categoria: Categoria(titulo: 'Urgente +\nImportante'),
                ),
                
                _SingleCard(
                  titulo: 'Urgente + No Importante', 
                  numero: 10, 
                  icon: FontAwesomeIcons.bolt,
                  color: Colors.yellow.shade900,
                  categoria: Categoria(titulo: 'Urgente +\n No Importante'),
                ),
              ]
            ),
            
            TableRow(
              children: [
                 _SingleCard(
                  titulo: 'No urgente + Importante', 
                  numero: 10, 
                  icon: FontAwesomeIcons.bath,
                  color: Colors.purple,
                  categoria: Categoria(titulo: 'No urgente +\n Importante'),
                ),
                
                _SingleCard(
                  titulo: 'No Urgente + No Importante', 
                  numero: 10, 
                  icon: FontAwesomeIcons.basketball,
                  color: Colors.green.shade700,
                  categoria: Categoria(titulo: 'No Urgente +\n No Importante'),
                ),
              ]
            )
          ],
        ),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {

  final String titulo;
  final int numero;
  final IconData icon;
  final Color color;
  final Categoria categoria;

  const _SingleCard({
    required this.titulo, 
    required this.numero, 
    required this.icon, 
    required this.color, 
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 140,
      width: 140, // TODO: revisar expansion de pixeles de pantalla
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20)
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'detalleCategoria', arguments: categoria),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 20,
                child: Icon(icon, color: Colors.white),
              ),
      
              Text('$numero Actividades', style: GoogleFonts.inter(),),
              
              Text(titulo, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}