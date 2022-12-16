import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class years extends StatefulWidget {
  const years({super.key});

  @override
  State<years> createState() => _yearsState();
}

class _yearsState extends State<years> {
  final meses = ['2022', '2023', '2024'];
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
