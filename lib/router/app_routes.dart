import 'package:flutter/material.dart';
import 'package:timescom/models/screen_def.dart';
import 'package:timescom/screens/auth/main_screen.dart';
import 'package:timescom/screens/screens.dart';

class AppRoutes {
  // Si quieren ver su pantalla al compilar cambien este
  static const initialRoute = 'bienvenidoScreen';

  static final listScreens = <ScreenDef>[
    // ScreenDef(route: 'welcomeScreen', name: 'Pantalla bienvenida', screen: screen)
    // ScreenDef(route: 'loginScreen', name: 'Pantalla inicio de sesion', screen: screen)
    ScreenDef(route: 'registroScreen', name: 'Pantalla registro de alumno', screen: const RegistroScreen()),
    ScreenDef(route: 'authScreen', name: 'Servicio de autenticacion', screen: const MainScreen()),
    // ScreenDef(route: 'loginScreen', name: 'Pantalla inicio de sesión de alumno', screen: LoginPage()),
    ScreenDef(route: 'mainMatrizScreen', name: 'Pantalla vista matriz', screen: const MainMatrizScreen()),
    ScreenDef(route: 'detalleCategoria', name: 'Pantalla vista de categoria', screen: const DetalleCategoriaScreen()),
    ScreenDef(route: 'detalleActividad', name: 'Pantalla vista de actividad', screen: const DetalleActividadScreen()),
    ScreenDef(route: 'detalleHabito', name: 'Pantalla vista de habito', screen: const DetalleHabito()),
    ScreenDef(route: 'pomodoroPage', name: 'Pantalla vista de pomodoro', screen: PomodoroPage()),
    ScreenDef(route: 'bienvenidoScreen', name: 'Pantalla bienvenida', screen: const WelcomeScreen()),
    ScreenDef(route: 'loginScreen', name: 'Pantalla bienvenida', screen: LoginScreen()),
    ScreenDef(route: 'seleccionRegIniScreen', name: 'Pantalla seleccion registro o inicio sesion', screen: const SeleccionRegIniScreen()),

  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes(){

    Map<String, Widget Function(BuildContext)> appRoutes = {};

    // appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for(final screen in listScreens){
      appRoutes.addAll({screen.route: (BuildContext context) => screen.screen});
    }

    return appRoutes;
  }
}