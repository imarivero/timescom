

import 'dart:async';
import 'dart:math';

import 'package:timescom/screens/charts/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWeek extends StatefulWidget {

  final String titulo;
  final String periodo;
  final List<int> valores;
  final Color backgroundColor;

  const BarChartWeek({super.key,
   required this.titulo,
   required this.periodo,
   required this.valores, 
   required this.backgroundColor
  });

  List<Color> get availableColors => const <Color>[
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartWeekState();
}

class BarChartWeekState extends State<BarChartWeek> {
  final Color barBackgroundColor = Colors.white70;
  // final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {

    final Color backgroundColor = widget.backgroundColor;

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        // color: const Color(0xff81e5cd),
        color: backgroundColor,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    widget.titulo,
                    style: const TextStyle(
                      // color: Color(0xff0f4a3c),
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.periodo,
                    style: TextStyle(
                      // color: Color(0xff379982),
                      color: Colors.grey.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        isPlaying ? mainBarData() : mainBarData(),
                        // isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: IconButton(
            //       icon: Icon(
            //         isPlaying ? Icons.pause : Icons.play_arrow,
            //         color: const Color(0xff0f4a3c),
            //       ),
            //       onPressed: () {
            //         setState(() {
            //           isPlaying = !isPlaying;
            //           if (isPlaying) {
            //             refreshState();
            //           }
            //         });
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, 
    int maxVal, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow.darken())
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxVal.toDouble(), // TODO: manejarlo
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(List<int> value) => List.generate(7, (i) {
    int maxValue = value.reduce(max);
        switch (i) {
          case 0:
            return makeGroupData(0, value[i].toDouble(), maxValue, isTouched: i == touchedIndex, barColor: Colors.blueGrey);
          case 1:
            return makeGroupData(1, value[i].toDouble(), maxValue, isTouched: i == touchedIndex, barColor: Colors.blueGrey);
          case 2:
            return makeGroupData(2, value[i].toDouble(), maxValue, isTouched: i == touchedIndex, barColor: Colors.blueGrey);
          case 3:
            return makeGroupData(3, value[i].toDouble(), maxValue, isTouched: i == touchedIndex, barColor: Colors.blueGrey);
          case 4:
            return makeGroupData(4, value[i].toDouble(), maxValue, isTouched: i == touchedIndex, barColor: Colors.blueGrey);
          case 5:
            return makeGroupData(5, value[i].toDouble(), maxValue, isTouched: i == touchedIndex, barColor: Colors.blueGrey);
          case 6:
            return makeGroupData(6, value[i].toDouble(), maxValue, isTouched: i == touchedIndex, barColor: Colors.blueGrey);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {

    // List<int> values = [10, 7, 1, 8, 16, 9, 15];

    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Lunes';
                break;
              case 1:
                weekDay = 'Martes';
                break;
              case 2:
                weekDay = 'Miercoles';
                break;
              case 3:
                weekDay = 'Jueves';
                break;
              case 4:
                weekDay = 'Viernes';
                break;
              case 5:
                weekDay = 'Sábado';
                break;
              case 6:
                weekDay = 'Domingo';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        // TODO: Descomentar si quieren esconder la escala lateral
        // leftTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: false,
        //   ),
        // ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(widget.valores),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      // color: Colors.blueGrey,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Lu', style: style);
        break;
      case 1:
        text = const Text('Ma', style: style);
        break;
      case 2:
        text = const Text('Mi', style: style);
        break;
      case 3:
        text = const Text('Ju', style: style);
        break;
      case 4:
        text = const Text('Vi', style: style);
        break;
      case 5:
        text = const Text('Sa', style: style);
        break;
      case 6:
        text = const Text('Do', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  // BarChartData randomData() {
  //   return BarChartData(
  //     barTouchData: BarTouchData(
  //       enabled: false,
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: getTitles,
  //           reservedSize: 38,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //       topTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //       rightTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: false,
  //     ),
  //     barGroups: List.generate(7, (i) {
  //       switch (i) {
  //         case 0:
  //           return makeGroupData(
  //             0,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 1:
  //           return makeGroupData(
  //             1,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 2:
  //           return makeGroupData(
  //             2,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 3:
  //           return makeGroupData(
  //             3,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 4:
  //           return makeGroupData(
  //             4,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 5:
  //           return makeGroupData(
  //             5,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 6:
  //           return makeGroupData(
  //             6,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         default:
  //           return throw Error();
  //       }
  //     }),
  //     gridData: FlGridData(show: false),
  //   );
  // }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}