import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/models/categoria.dart';
import 'package:timescom/providers/providers.dart';

class CardTable extends StatelessWidget {

  const CardTable({super.key});

  @override
  Widget build(BuildContext context) {

    final taskProvider = Provider.of<TaskProvider>(context);
    
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
                  numero: taskProvider.listActividadesUrgIm.length, 
                  icon: FontAwesomeIcons.exclamation,
                  color: Colors.red,
                  categoria: Categoria(titulo: 'urgente+importante', descripcion: 'Urgente +\nImportante'),
                ),
                
                _SingleCard(
                  titulo: 'Urgente + No Importante', 
                  numero: taskProvider.listActividadesUrgNim.length, 
                  icon: FontAwesomeIcons.bolt,
                  color: Colors.yellow.shade900,
                  categoria: Categoria(titulo: 'urgente+noimportante', descripcion: 'Urgente +\n No Importante'),
                ),
              ]
            ),
            
            TableRow(
              children: [
                 _SingleCard(
                  titulo: 'No urgente + Importante', 
                  numero: taskProvider.listActividadesNurgIm.length, 
                  icon: FontAwesomeIcons.bath,
                  color: Colors.purple,
                  categoria: Categoria(titulo: 'nourgente+importante', descripcion: 'No urgente +\n Importante'),
                ),
                
                _SingleCard(
                  titulo: 'No Urgente + No Importante', 
                  numero: taskProvider.listActividadesNurgNim.length, 
                  icon: FontAwesomeIcons.basketball,
                  color: Colors.green.shade700,
                  categoria: Categoria(titulo: 'nourgente+noimportante', descripcion: 'No Urgente +\n No Importante'),
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
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'categoriaActividad', arguments: categoria),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: width/2.5,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20)
        ),
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