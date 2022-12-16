import 'package:timescom/widgets/drop_horas.dart';
import 'package:timescom/widgets/drop_meses.dart';
import 'package:flutter/material.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistroHabito extends StatelessWidget {
  const RegistroHabito({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'titulo habito': 'titulo',
      'descripcion habito': 'descripcion',
      'hora habito': 'hora'
    };

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: myFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text('Registro de Habito',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomInputTextField(
                  hintText: 'titulo habito',
                  formProperty: 'ingresa un titulo',
                  formValues: formValues,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomInputTextField(
                  hintText: 'Descripcion ',
                  formProperty: 'descripcion habito',
                  formValues: formValues,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Hora(Opcional)"),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                      hora(formValues: formValues, formProperty: 'hora habito'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text("Dias"),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          dias(inicialDia: "Lu"),
                          dias(inicialDia: "Ma"),
                          dias(inicialDia: "Mie"),
                          dias(inicialDia: "Ju"),
                          dias(inicialDia: "Vi"),
                          dias(inicialDia: "Sa"),
                          dias(inicialDia: "Do"),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Al presionar guardar, se esconde el teclado
                      FocusScope.of(context).requestFocus(FocusNode());
                      print(formValues);
                    },
                    child: const Text(
                      'Añadir Habito',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class dias extends StatefulWidget {
  final String inicialDia;
  const dias({
    Key? key,
    required this.inicialDia,
  }) : super(key: key);

  @override
  State<dias> createState() => _diasState();
}

class _diasState extends State<dias> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {});
        },
        child: Text(
          widget.inicialDia,
          style: TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}

class seleccion extends StatelessWidget {
  final String tipo;
  const seleccion({
    Key? key,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    tipo,
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MaterialStateProperty<Color> cambiarColor(Color color, Color colorPressed) {
//   final cambiarColor = (Set states) {
//     if (states.contains(MaterialState.pressed)) {
//       return colorPressed;
//     } else {
//       return color;
//     }
//   };

//   return MaterialStateProperty.resolveWith(cambiarColor);
// }
