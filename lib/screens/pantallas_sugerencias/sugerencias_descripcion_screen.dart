import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timescom/providers/sugerencia_service.dart';
import 'package:timescom/widgets/widgets_sugerencias_screen/sugerencia_image.dart';

//!!ESTA TARJETA ES DONDE VERAN LA DESCRIPCION DEL WIDGET
class SugerenciasDescripcionScreen extends StatelessWidget {
  const SugerenciasDescripcionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final habitosugerencia = Provider.of<HabitsSugerenciasService>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 227, 227),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SugerenciaImage(
                    url: habitosugerencia.habitoSeleccionado.imagenurl),
                Positioned(
                  top: 30,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),

            const _Sugerenciacontainer(),

            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class _Sugerenciacontainer extends StatelessWidget {
  const _Sugerenciacontainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final habitosugerencia = Provider.of<HabitsSugerenciasService>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(45),
              bottomLeft: Radius.circular(45),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  offset: const Offset(0, 14),
                  blurRadius: 5)
            ]),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 5, color: const Color.fromARGB(255, 10, 234, 141))),
              child: Text(
                habitosugerencia.habitoSeleccionado.titulo,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                habitosugerencia.habitoSeleccionado.descripcion,
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}