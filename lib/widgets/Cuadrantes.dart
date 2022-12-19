import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SeleccionPrioridad extends StatefulWidget {
  final String formProperty;
  final Map<String, String> formValues;
  const SeleccionPrioridad(
      {super.key, required this.formProperty, required this.formValues});

  @override
  State<SeleccionPrioridad> createState() => _SeleccionPrioridadState();
}

class _SeleccionPrioridadState extends State<SeleccionPrioridad> {
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
