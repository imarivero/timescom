import 'dart:async';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'ScreenSize_reduces.dart';
import 'package:intl/intl.dart';
//import 'package:flutter/rendering.dart';

class PomodoroPage extends StatefulWidget {
  PomodoroPage({Key? key}) : super(key: key);

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  /*
  double _progreso = 0;
  static int _minutos = 25;
  int _segundos = _minutos * 60;
  static const maxSeconds = 25;
  int seconds = maxSeconds;
  Timer? tiempo;
  int _start = 2;
  int _startSegundos = 59;
  */

  int seconds = 00;
  int minutes = 25;
  Timer? timer;
  int minutos_transcurridos = 00;
  var f = NumberFormat("00");
  double progreso = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //height: auxi_alto,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 85, 117, 207),
            Color.fromARGB(255, 97, 172, 247)
          ], begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "",
                    style: TextStyle(color: Colors.white, fontSize: 50.0),
                  ),
                ),
                Expanded(
                    child: CircularPercentIndicator(
                  percent: progreso,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 140.0,
                  lineWidth: 20.0,
                  progressColor: Colors.green,
                  center: Text("${f.format(minutes)} : ${f.format(seconds)}",
                      style: TextStyle(color: Colors.white, fontSize: 60.0)),
                )),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /*
                      FloatingActionButton(
                        onPressed: (() {
                          print("Boton de pausa");
                        }),
                        child: Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.grey,
                      ), */
                      FloatingActionButton(
                        onPressed: (() {
                          setState(() {
                            _detenerPomodoro();
                            print("Botón de stop");
                          });
                        }),
                        child: Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      FloatingActionButton(
                        onPressed: (() {
                          setState(() {
                            _iniciarPomodoro();
                            //print("Botón de play");
                          });
                        }),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  ),
                )
                /*
                Expanded(
                    child: FloatingActionButton(
                  onPressed: () {
                    print("Funcionalidad");
                  },
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.grey,
                )
                ),*/
              ]),
        ),
      ),
    );
  }

  void _detenerPomodoro() {
    timer?.cancel();
    seconds = 00;
    minutes = 25;
    progreso = 0;
    minutos_transcurridos = 00;
  }

  void _iniciarPomodoro() {
    if (timer != null) {
      _detenerPomodoro();
    }
    if (minutes > 0) {
      seconds = minutes * 60;
    }
    if (seconds > 60) {
      minutes = (seconds / 60).floor();
      seconds -= (minutes * 60);
    }
    int time_auxi = minutes * 60;
    double auxi_progreso = (time_auxi / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          if (minutes > 0) {
            seconds = 59;
            minutes--;
            minutos_transcurridos = 25 - minutes;
            progreso = minutos_transcurridos / 25;
          } else {
            progreso = 0;
            timer.cancel();
            print("Timer Complete");
          }

/*
          if (minutes % 2 == 0) {
            if (progreso < 1) {
              progreso = minutes / 25;
            } else {
              progreso = 1;
              print("Timer al 100%");
            }
          }*/
        }
      });
    });
    /*
    timer = Timer.periodic(Duration(seconds: 120), (timer) {
      this.segundos--;
      setState(() {});
    });
    */
    /*
    const oneSec = const Duration(seconds: 1);
    tiempo = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 25;
          });
        } else {
          setState(() {
            _startSegundos--;
            if (_startSegundos == 0) {
              _start--;
              _startSegundos = 59;
            }
            //_start--;
          });
        }
      },
    );
    */
  }
  /*
  String formatearTiempo() {
    Duration duracion = Duration(seconds: this.segundos);
    int segundos = duracion.inSeconds;
    int minutos =25;
    return "$minutos:$segundos";
  }
  */
}
