import 'package:flutter/material.dart';

class CumplimientoHabito extends StatefulWidget {
  CumplimientoHabito({Key? key}) : super(key: key);

  @override
  State<CumplimientoHabito> createState() => _CumplimientoHabitoState();
}

class _CumplimientoHabitoState extends State<CumplimientoHabito> {
  bool _completado = false;
  String _habito = "Comer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(children: <Widget>[
          Center(
            child: Text(
              '¿Ya cumpliste con tus hábitos?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Divider(
            height: 30,
          ),
          _crearCheckBox(),
        ]),
      ),
    );
  }

  Widget _crearCheckBox() {
    return CheckboxListTile(
        title: Text('$_habito'),
        value: _completado,
        onChanged: (valor) {
          setState(() {
            _completado = valor!;
          });
        });
  }
}
