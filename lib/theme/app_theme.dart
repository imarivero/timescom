import 'package:flutter/material.dart';

class AppTheme{
  
  // TODO: Usar el azul que teniamos en mente
  static const Color primary = Colors.blue;

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.black,

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        minimumSize: const Size(240.0, 46.0)
      )
    ),

    

  );
}