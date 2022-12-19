import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/screens/loading_screen.dart';
import 'package:timescom/services/sugerencia_service.dart';
import 'package:timescom/widgets/sugerencia_card.dart';

import '../theme/colors.dart';

//!ESTA ES LA PANTALLA DONDE APARECEN TODOS LOS HABITOS SUGERIDOSS
class SugerenciasScreen extends StatelessWidget {
  const SugerenciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitossugerencia = Provider.of<HabitsSugerenciasService>(context);
    if (habitossugerencia.isLoading) return const LoadingScreen();

    return Scaffold(
      backgroundColor: const Color.fromARGB(170, 115, 128, 180),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text("Sugerencias"),
        flexibleSpace: const ColorAppbar(),
      ),
      body: ListView.builder(
        itemCount: habitossugerencia.habitossugeridos.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: SugerenciaCard(
              habito: habitossugerencia.habitossugeridos[index],
            ),
            onTap: () {
              habitossugerencia.habitoSeleccionado =
                  habitossugerencia.habitossugeridos[index].copy();
              Navigator.pushNamed(context, 'descripcionsugerencia');
            },
          );
        },
      ),
    );
  }
}
