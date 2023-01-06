import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/providers.dart';
import 'package:timescom/screens/charts/bar_chart_week.dart';

class DesempenioScreen extends StatelessWidget {
   
  const DesempenioScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final registrosProvider = Provider.of<RegistrosProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
        
              Center(
                child: Text('Desempeño', 
                  style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)
                )
              ),
        
              const SizedBox(height: 40,),
              
              if(registrosProvider.registroSemanaActual == null && registrosProvider.registroSemanaPasada == null)
                Center(
                  child: Text('Parece que aún no has generado ningún registro.',
                    textAlign: TextAlign.center, 
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)
                  )
                ),
              
              if(registrosProvider.registroSemanaActual != null)
                const _ChartsWeek(tipo: 1,),

              if(registrosProvider.registroSemanaPasada != null)
                const Divider(),
              
              if(registrosProvider.registroSemanaPasada != null)
                const _ChartsWeek(tipo: 2,),

            ],
          ),
        ),
      ),
    );
  }
}

class _ChartsWeek extends StatelessWidget {

  final int tipo; // tipo = 0 semana pasada, tipo = 1 semana actual

  const _ChartsWeek({
    Key? key, required this.tipo,
  }) : super(key: key);

  List<int> valuesFromMap(Map<String, int> valoresSemana){
    List<int> values = [0, 0, 0, 0, 0, 0, 0, 0];

    if(valoresSemana.isEmpty){return values;}

    values[0] = valoresSemana['Lu']!;
    values[1] = valoresSemana['Ma']!;
    values[2] = valoresSemana['Mi']!;
    values[3] = valoresSemana['Ju']!;
    values[4] = valoresSemana['Vi']!;
    values[5] = valoresSemana['Sa']!;
    values[6] = valoresSemana['Do']!;
    return values;
  }

  @override
  Widget build(BuildContext context) {

    final registrosProvider = Provider.of<RegistrosProvider>(context);

    final double width = MediaQuery.of(context).size.width;
    String semanaPeriodo = '';
    List<int> valuesActividades = [];
    List<int> valuesHabitos = [];
    List<int> valuesPomodoros = [];
    // List<int> valuesActividades = [10, 7, 1, 8, 16, 9, 20];


    if(registrosProvider.registroSemanaActual != null && tipo == 1){

      valuesActividades = valuesFromMap(registrosProvider.registroSemanaActual!.registroActividades);
      valuesHabitos = valuesFromMap(registrosProvider.registroSemanaActual!.registroHabitos);
      valuesPomodoros = valuesFromMap(registrosProvider.registroSemanaActual!.registroPomodoros);

      semanaPeriodo = '${registrosProvider.registroSemanaActual!.fechaInicio} al ${registrosProvider.registroSemanaActual!.fechaFinal}';
    
    } else if(registrosProvider.registroSemanaPasada != null && tipo == 0){

      valuesActividades = valuesFromMap(registrosProvider.registroSemanaPasada!.registroActividades);
      valuesHabitos = valuesFromMap(registrosProvider.registroSemanaPasada!.registroHabitos);
      valuesPomodoros = valuesFromMap(registrosProvider.registroSemanaPasada!.registroPomodoros);

      semanaPeriodo = '${registrosProvider.registroSemanaPasada!.fechaInicio} al ${registrosProvider.registroSemanaPasada!.fechaFinal}';
    }

    return Column(
      children: [
        if(valuesActividades.isNotEmpty)
          Center(
            child: SizedBox(
              width: width - 90,
              height: width - 90,
              child: BarChartWeek(
                titulo: 'Actividades completadas',
                periodo: semanaPeriodo,
                valores: valuesActividades,
                backgroundColor: Colors.indigo,
              ),
            ),
          ),

        if(valuesHabitos.isNotEmpty)
        Center(
          child: SizedBox(
            width: width - 90,
            height: width - 90,
            child: BarChartWeek(
              titulo: 'Hábitos completados',
              periodo: semanaPeriodo,
              valores: valuesHabitos,
              backgroundColor: Colors.deepOrange,
            ),
          ),
        ),

        if(valuesPomodoros.isNotEmpty)
          Center(
            child: SizedBox(
              width: width - 90,
              height: width - 90,
              child: BarChartWeek(
                titulo: 'Pomodoros completados',
                periodo: semanaPeriodo,
                valores: valuesPomodoros,
                // backgroundColor: Color(0xfdcae1),
                backgroundColor: Colors.teal,
              ),
            ),
          ),
      ],
    );
  }
}