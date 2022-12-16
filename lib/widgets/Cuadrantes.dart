import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class prioridad extends StatefulWidget {
  final String formProperty;
  final Map<String, String> formValues;
  const prioridad(
      {super.key, required this.formProperty, required this.formValues});

  @override
  State<prioridad> createState() => _prioridadState();
}

class _prioridadState extends State<prioridad> {
  final meses = [
    'Importante',
    'Importante + Urgente',
    ' Urgente + no importante',
    ' NO Urgente + no importante',
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
