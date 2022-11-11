import 'dart:async';
//import 'dart:html';

import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
// TODO: De donde viene screenSize_reduces?
// import 'ScreenSize_reduces.dart';
//import 'package:flutter/rendering.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({Key? key}) : super(key: key);

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  final double _progreso = 0;
  static int _minutos = 25;
  final int _segundos = _minutos * 60; 
  static const maxSeconds = 25;
  int seconds = maxSeconds;
  Timer? tiempo;
  int _start = 2;
  int _startSegundos = 59;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //height: auxi_alto,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Pomodoro",
                    style: TextStyle(color: Colors.white, fontSize: 50.0),
                  ),
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    percent: _progreso,
                    animation: true,
                    animateFromLastPercent: true,
                    radius: 140.0,
                    lineWidth: 20.0,
                    progressColor: Colors.white,
                    center: const Text("25:00",
                        style: TextStyle(color: Colors.white, fontSize: 60.0)),
                  )),
                const SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: (() {
                          print("Boton de pausa");
                        }),
                        backgroundColor: Colors.grey,
                        child: const Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: (() {
                          _iniciarPomodoro();
                          //print("Botón de play");
                        }),
                        backgroundColor: Colors.grey,
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: (() {
                          _detenerPomodoro();
                          print("Botón de stop");
                        }),
                        backgroundColor: Colors.grey,
                        child: const Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
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
    tiempo?.cancel();
    //super.dispose();
  }

  void _iniciarPomodoro() {
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
  }
}
