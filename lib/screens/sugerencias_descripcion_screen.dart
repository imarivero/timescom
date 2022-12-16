import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:timescom/services/sugerencia_service.dart';
import 'package:timescom/widgets/sugerencia_image.dart';
import 'package:timescom/widgets/youtube_player.dart';

//!!ESTA TARJETA ES DONDE VERAN LA DESCRIPCION DEL WIDGET
class SugerenciasDescripcionScreen extends StatelessWidget {
  const SugerenciasDescripcionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitosugerencia = Provider.of<HabitsSugerenciasService>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 227, 227),
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
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
            _Sugerenciacontainer(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {},
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
        margin: EdgeInsets.symmetric(vertical: 1),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 5, color: Color.fromARGB(255, 10, 234, 141))),
              child: Text(
                habitosugerencia.habitoSeleccionado.titulo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                habitosugerencia.habitoSeleccionado.descripcion,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                habitosugerencia.habitoSeleccionado.descripcion,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(45),
              bottomLeft: Radius.circular(45),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  offset: Offset(0, 14),
                  blurRadius: 5)
            ]),
      ),
    );
  }
}
