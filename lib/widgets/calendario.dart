import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoCalendarPAGE extends StatefulWidget {
  final String formProperty;
  final Map<String, String> formValues;
  const CupertinoCalendarPAGE(
      {super.key, required this.formProperty, required this.formValues});

  @override
  State<CupertinoCalendarPAGE> createState() => _CupertinoCalendarPAGEState();
}

class _CupertinoCalendarPAGEState extends State<CupertinoCalendarPAGE> {
  late DateTime fecha;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (date) {
          setState(() {
            fecha = date;
          });
        },
      ),
    );
  }
}
