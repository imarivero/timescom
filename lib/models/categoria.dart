import 'package:timescom/models/actividad.dart';
import 'package:timescom/models/habito.dart';

class Categoria{

  String titulo;
  String descripcion;
  List<Actividad>? listaActividad;
  List<Habito>? listaHabito;

  Categoria({
    required this.titulo,
    required this.descripcion,
  });
  
  
}