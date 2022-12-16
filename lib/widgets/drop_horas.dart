import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class hora extends StatefulWidget {
  final String formProperty;
  final Map<String, String> formValues;
  const hora({super.key, required this.formProperty, required this.formValues});

  @override
  State<hora> createState() => _horaState();
}

class _horaState extends State<hora> {
  final meses = [
    '01:00',
    '02:00',
    '03:00',
    '04:00',
    '05:00',
    '06:00',
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
    '24:00',
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
