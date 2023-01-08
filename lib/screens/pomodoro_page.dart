import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/timer_provider.dart';

import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/custom_navbar.dart';

class PomodoroPage extends StatefulWidget {
  
  const PomodoroPage({Key? key}) : super(key: key);

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {

  @override
  Widget build(BuildContext context) {

    final timerProvider = Provider.of<TimerProvider>(context);
    timerProvider.setBuildContext = context;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 30.0),

            Center(
              child: Text('Temporizador \nPomodoro', 
                style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ),

            const SizedBox(height: 30.0),

            Center(
              child: CircularPercentIndicator(
                percent: timerProvider.percentCompleted,
                animation: true,
                animateFromLastPercent: true,
                radius: 140.0,
                lineWidth: 20.0,
                progressColor: AppTheme.primary,
                center: Text(
                  timerProvider.timeLeftString,
                  style: const TextStyle(color: Colors.white, fontSize: 60.0)
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            if(!timerProvider.yaInicioUnPomodoro)
              Center(
                child: Text(
                  'Podemos comenzar cuando mejor te parezca.',
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ),

            if(timerProvider.yaInicioUnPomodoro)
              Center(
                child: Text(
                  timerProvider.wasWorking ?
                  'Es momento de trabajar 🖋️' :
                  'Un descanso bien merecido 😴', 
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ),

            const _Controles()
          ]
        ),
        bottomNavigationBar: const CustomNavBar(),
      ),
    );
  }
}

class _Controles extends StatelessWidget {
  
  const _Controles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final timerProvider = Provider.of<TimerProvider>(context);

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: (){
              timerProvider.startStopTimer();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(30, 30),
            ),
            child: timerProvider.isRunning ?
             const Icon(Icons.pause, size: 40,) : 
             const Icon(Icons.play_arrow, size: 40,),
          ),
          ElevatedButton(
            onPressed: (){
              timerProvider.reiniciarPomodoro();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(30, 30),
            ),
            child: const Icon(Icons.stop, size: 40,),
          ),
        ],
      ),
    );
  }
}
