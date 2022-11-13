import 'package:flutter/material.dart';
import 'package:timescom/models/screen_def.dart';
import 'package:timescom/screens/screens.dart';

class AppRoutes {
  // Si quieren ver su pantalla al compilar cambien este
  static const initialRoute = 'mainMatrizScreen';

  static final listScreens = <ScreenDef>[
    // ScreenDef(route: 'welcomeScreen', name: 'Pantalla bienvenida', screen: screen)
    // ScreenDef(route: 'loginScreen', name: 'Pantalla inicio de sesion', screen: screen)
    ScreenDef(route: 'regisAlumnoScreen', name: 'Pantalla registro de alumno', screen: const RegistroAlumnoScreen()),
    ScreenDef(route: 'mainMatrizScreen', name: 'Pantalla vista matriz', screen: const MainMatrizScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes(){

    Map<String, Widget Function(BuildContext)> appRoutes = {};

    // appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for(final screen in listScreens){
      appRoutes.addAll({screen.route: (BuildContext context) => screen.screen});
    }

    return appRoutes;
  }

  // static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  //   return MaterialPageRoute(
  //   // builder: (context) => const AlertScreen());
  // }
}