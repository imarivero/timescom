import 'package:flutter/material.dart';
import 'package:timescom/models/screen_def.dart';
import 'package:timescom/screens/screens.dart';

class AppRoutes {
  // Si quieren ver su pantalla al compilar cambien este
  static const initialRoute = 'checkscreen';
  static final listScreens = <ScreenDef>[
    ScreenDef(
        route: 'regisAlumnoScreen',
        name: 'Pantalla registro de alumno',
        screen: const RegistroAlumnoScreen()),
    ScreenDef(
        route: 'loginScreen',
        name: 'Pantalla inicio de sesión de alumno',
        screen: LoginPage()),
    ScreenDef(
        route: 'mainMatrizScreen',
        name: 'mainMatrizScreen',
        screen: MainMatrizScreen()),
    ScreenDef(
        route: 'detalleCategoria',
        name: 'Pantalla vista de categoria',
        screen: const DetalleCategoriaScreen()),
    ScreenDef(
        route: 'detalleActividad',
        name: 'Pantalla vista de actividad',
        screen: const DetalleActividadScreen()),
    ScreenDef(
        route: 'detalleHabito',
        name: 'Pantalla vista de habito',
        screen: const DetalleHabito()),
    ScreenDef(
        route: 'pomodoroPage',
        name: 'Pantalla vista de pomodoro',
        screen: PomodoroPage()),
    ScreenDef(
        route: 'bienvenidoScreen',
        name: 'Pantalla bienvenida',
        screen: const WelcomeScreen()),
    ScreenDef(
        route: 'seleccionRegIniScreen',
        name: 'Pantalla seleccion registro o inicio sesion',
        screen: const SeleccionRegIniScreen()),
    ScreenDef(route: 'slow', name: 'slow', screen: const SlideShowPage1()),
    ScreenDef(
        route: 'modificarhabito',
        name: 'modificarhabito',
        screen: const ModificarHabito()),
    ScreenDef(
        route: 'modificaractividad',
        name: 'modificaractividad',
        screen: const ModificarActividad()),
    ScreenDef(
        route: 'modificaractividad',
        name: 'modificaractividad',
        screen: const ModificarActividad()),
    ScreenDef(
        route: 'registraractividad',
        name: 'registraractividad',
        screen: const RegistroActividad()),
    ScreenDef(
        route: 'registrarhabito',
        name: 'registrarhabito',
        screen: const RegistroHabito()),
    ScreenDef(
        route: 'ModificarPerfil',
        name: 'ModificarPerfil',
        screen: ModificarPerfil()),
    ScreenDef(
        route: 'sugerencias', name: 'sugerencias', screen: SugerenciasScreen()),
    ScreenDef(route: 'checkscreen', name: 'checkscreen', screen: CheckScreen()),
    ScreenDef(
      route: 'perfil',
      name: 'perfil',
      screen: Perfil(),
    ),
    ScreenDef(
      route: 'descripcionsugerencia',
      name: 'descripcionsugerencia',
      screen: const SugerenciasDescripcionScreen(),
    ),
    ScreenDef(
      route: 'desempeno',
      name: 'desempeno',
      screen: const DesempeScreen(),
    ),
    ScreenDef(
      route: 'desempeno2',
      name: 'desempeno2',
      screen: const DesempeScreen2(),
    ),
    ScreenDef(
      route: 'desempeno3',
      name: 'desempeno3',
      screen: desempenio3Screen(),
    ),
    ScreenDef(
      route: 'desempenio',
      name: 'desempenio',
      screen: DesempenioScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    // appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for (final screen in listScreens) {
      appRoutes.addAll({screen.route: (BuildContext context) => screen.screen});
    }

    return appRoutes;
  }
}
