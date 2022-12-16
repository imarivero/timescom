import 'package:flutter/material.dart';

class NotificationService {
  static late GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String messsage) {
    final snackBar = new SnackBar(
        content: Text(
      messsage,
      style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
