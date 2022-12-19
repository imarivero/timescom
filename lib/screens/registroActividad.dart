import 'package:timescom/widgets/cuadrantes.dart';
import 'package:timescom/widgets/calendario.dart';
import 'package:timescom/widgets/drop_meses.dart';
import 'package:flutter/material.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistroActividad extends StatelessWidget {
  const RegistroActividad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'titulo': 'titulo',
      'descripcion': 'descripcion',
      'cuadrante': 'Importante',
      'fecha': 'fecha',
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
                  child: Text('Registro de actividad',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomInputTextField(
                  hintText: 'Titulo de la actividad(s)',
                  formProperty: 'tituloactividad',
                  formValues: formValues,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomInputTextField(
                  hintText: 'Descripcion de la actividad',
                  formProperty: 'Descripcion de actividad',
                  formValues: formValues,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text("Fecha limite(Opcional)"),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     CupertinoCalendarPAGE()
                //   ],
                // ),
                CupertinoCalendarPAGE(
                    formProperty: 'fecha', formValues: formValues),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text(
                      "Cuadrante(Opcional)",
                    ),
                    SeleccionPrioridad(
                      formProperty: 'cuadrante',
                      formValues: formValues,
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
                      'Añadir actividad',
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

class Seleccion extends StatelessWidget {
  final String tipo;
  const Seleccion({
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
                  const Icon(
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
