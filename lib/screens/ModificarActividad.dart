import 'package:timescom/widgets/drop_meses.dart';
import 'package:flutter/material.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ModificarActividad extends StatelessWidget {
  const ModificarActividad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {};

    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: myFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('Modificar actividad',
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
                formProperty: 'Actvidad',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  seleccion(tipo: "Dia"),
                  seleccion(tipo: "Mes"),
                  seleccion(tipo: "año"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Text(
                    "Cuadrante(Opcional)",
                  ),
                  seleccion(tipo: "Prioridad"),
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
                    'Guardar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
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
