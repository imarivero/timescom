import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/providers.dart';

class TimerProvider extends ChangeNotifier {

  BuildContext? context;

  static const int _minutosTrabajo = 2;
  static const int _minutosDescanso = 1;

  
  Duration duration = const Duration(minutes: _minutosTrabajo);
  Duration durationFixed = const Duration(minutes: _minutosTrabajo);

  bool wasWorking = true; // Para distinguir si termino un pomodoro de un descanso
  bool isRunning = false;
  bool yaInicioUnPomodoro = false;

  StreamSubscription<int>? _tickSubscription;

  void startStopTimer() {
    if (!isRunning) {
      _startTimer(duration.inSeconds);
    } else {
      // Pausar el timer
      _tickSubscription?.pause();
    }

    isRunning = !isRunning;
    notifyListeners();
  }

  void _startTimer(int seconds) {
    yaInicioUnPomodoro = true;
    _tickSubscription?.cancel();

    _tickSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (sec) => seconds - sec - 1)
        .take(seconds)
        .listen((timeLeftInSeconds) {

      duration = Duration(seconds: timeLeftInSeconds);

      if(timeLeftInSeconds == 0){
        // Termino un temporizador
        if(wasWorking){
          duration = const Duration(minutes: _minutosDescanso);
          durationFixed = const Duration(minutes: _minutosDescanso);

          final registrosProvider = Provider.of<RegistrosProvider>(context!, listen: false);
          registrosProvider.actualizarRegistroCategoria('pomodoro');

        } else{
          duration = const Duration(minutes: _minutosTrabajo);
          durationFixed = const Duration(minutes: _minutosTrabajo);
        }
        wasWorking = !wasWorking;
        isRunning = !isRunning;
      }

      notifyListeners();
    });
  }

  void reiniciarPomodoro() {

    _tickSubscription?.cancel();
    isRunning = false;
    wasWorking = false;
    yaInicioUnPomodoro = false;

    durationFixed = const Duration(minutes: _minutosTrabajo);
    duration = const Duration(minutes: _minutosTrabajo);

    notifyListeners();
  }

  String get timeLeftString {
    final minutes =
        ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        (duration.inSeconds % 60).floor().toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
  
  double get percentCompleted {
    double porcentaje =  (duration.inSeconds / durationFixed.inSeconds) - 1;

    return porcentaje.abs();
  }

  set setBuildContext(BuildContext context){
    this.context = context;
  }
}