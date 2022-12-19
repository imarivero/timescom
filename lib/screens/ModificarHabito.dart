import 'package:timescom/widgets/drop_meses.dart';
import 'package:flutter/material.dart';
import 'package:timescom/widgets/custom_input_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ModificarHabito extends StatelessWidget {
  const ModificarHabito({Key? key}) : super(key: key);

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
                child: Text('Modificar Habito',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomInputTextField(
                hintText: 'Titulo del habito',
                formProperty: 'ingresa un titulo',
                formValues: formValues,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomInputTextField(
                hintText: 'Descripcion ',
                formProperty: 'Descripcion del habito',
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
              Row(
                children: [
                  SeleccionHora(tipo: "Hora"),
                ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DiasPicker(inicialDia: "Lu"),
                      DiasPicker(inicialDia: "Ma"),
                      DiasPicker(inicialDia: "Mie"),
                      DiasPicker(inicialDia: "Ju"),
                      DiasPicker(inicialDia: "Vi"),
                      DiasPicker(inicialDia: "Sa"),
                      DiasPicker(inicialDia: "Do"),
                    ],
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

class DiasPicker extends StatelessWidget {
  final String inicialDia;
  const DiasPicker({
    Key? key,
    required this.inicialDia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Center(
                child: Text(
              inicialDia,
              style: TextStyle(color: Colors.black),
            )),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.white),
          )
        ],
      ),
    );
  }
}

class SeleccionHora extends StatelessWidget {
  final String tipo;
  const SeleccionHora({
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
