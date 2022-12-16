import 'package:flutter/material.dart';
import 'package:timescom/screens/desempe%C3%B1o.dart';
import 'package:timescom/screens/desempenio2.dart';
import 'package:timescom/screens/desempenio3.dart';
import 'package:timescom/theme/colors.dart';

class DesempenioScreen extends StatelessWidget {
  const DesempenioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Text("Vista de Desempeño"),
        flexibleSpace: ColorAppbar(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              textoredondeado(texto: "Numero de habitos cumplidos por dia"),
              SizedBox(
                height: 10,
              ),
              DesempeScreen2(),
              SizedBox(
                height: 10,
              ),
              textoredondeado(
                  texto: "habitos cumplidos estos meses,vamos por mas!"),
              desempenio3Screen(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle texto() {
    return TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  }
}

class textoredondeado extends StatelessWidget {
  final String texto;
  const textoredondeado({
    Key? key,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.05),
          borderRadius: BorderRadius.circular(25),
          border:
              Border.all(width: 5, color: Color.fromARGB(255, 10, 234, 141))),
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}
