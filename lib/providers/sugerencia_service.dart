import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:timescom/models/habito_sugerencia.dart';

class HabitsSugerenciasService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-2ad96-default-rtdb.firebaseio.com';

  final List<HabitoSugerencia> habitossugeridos = [];

  late HabitoSugerencia habitoSeleccionado;

  //todo hacer el fetch de productos
  bool isLoading = true;

  HabitsSugerenciasService() {
    cargarHabitos();
  }

  Future<List<HabitoSugerencia>> cargarHabitos() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'habits.json');
    final respuesta = await http.get(url);
    final Map<String, dynamic> habitosMap = jsonDecode(respuesta.body);

    habitosMap.forEach((key, value) {
      final tempHabito = HabitoSugerencia.fromMap(value);
      tempHabito.id = key;
      habitossugeridos.add(tempHabito);
    });

    isLoading = false;
    notifyListeners();

    return habitossugeridos;
  }
}
