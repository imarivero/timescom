import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Mes extends StatefulWidget {
  const Mes({super.key});

  @override
  State<Mes> createState() => _MesState();
}

class _MesState extends State<Mes> {
  final meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  String _vista = "Seleccione";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        items: meses.map((mes) {
          return DropdownMenuItem(
            child: Text(mes),
            value: mes,
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            _vista = value!;
          });
        },
        hint: Text(_vista),
      ),
    );
  }
}
