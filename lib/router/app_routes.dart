import 'package:flutter/material.dart';
import 'package:timescom/models/screen_def.dart';
import 'package:timescom/screens/pantallas_sugerencias/sugerencias_descripcion_screen.dart';
// import 'package:timescom/screens/auth/main_screen_deprecated.dart';
import 'package:timescom/screens/screens.dart';
import 'package:timescom/wrapper.dart';

class AppRoutes {
  // Si quieren ver su pantalla al compilar cambien este
  static const initialRoute = 'bienvenidoScreen';

  static final listScreens = <ScreenDef>[
    // ScreenDef(route: 'welcomeScreen', name: 'Pantalla bienvenida', screen: screen)
    ScreenDef(route: 'bienvenidoScreen', name: 'Pantalla bienvenida', screen: const WelcomeScreen()),
    ScreenDef(route: 'categoriaActividad', name: 'Pantalla vista de categoria actividad', screen: const CategoriaActividad()),
    ScreenDef(route: 'categoriaHabito', name: 'Pantalla vista de categoria habito', screen: const CategoriaHabito()),
    ScreenDef(route: 'crearActividad', name: 'Servicio de autenticacion', screen: const CrearActividadScreen()),
    ScreenDef(route: 'crearHabito', name: 'Servicio de autenticacion', screen: const CrearHabitoScreen()),
    ScreenDef(route: 'desempenioScreen', name: 'Pantalla vista de desempeno', screen: const DesempenioScreen()),
    ScreenDef(route: 'detalleActividad', name: 'Pantalla vista de actividad', screen: const DetalleActividadScreen()),
    ScreenDef(route: 'detalleHabito', name: 'Pantalla vista de habito', screen: const DetalleHabito()),
    ScreenDef(route: 'infoPerfil', name: 'Pantalla informacion de alumno', screen: const InfoPerfil()),
    ScreenDef(route: 'loginScreen', name: 'Pantalla de inicio de sesion', screen: const LoginScreen()),
    ScreenDef(route: 'mainMatrizScreen', name: 'Pantalla vista matriz', screen: const MainMatrizScreen()),
    ScreenDef(route: 'modificarActividad', name: 'Pantalla vista de modificacion de actividad', screen: const ModificarActividadScreen()),
    ScreenDef(route: 'modificarDatosAlumno', name: 'Pantalla modificacion de datos de alumno', screen: const ModificarDatos()),
    ScreenDef(route: 'modificarHabito', name: 'Pantalla modificacion de habito', screen: const ModificarHabitoScreen()),
    ScreenDef(route: 'modificarPassword', name: 'Pantalla modificacion de contrasena', screen: const CambiarPassword()),
    ScreenDef(route: 'pomodoroPage', name: 'Pantalla vista de pomodoro', screen: PomodoroPage()),
    ScreenDef(route: 'registroScreen', name: 'Pantalla registro de alumno', screen: const RegistroScreen()),
    ScreenDef(route: 'restaurarPasswordScreen', name: 'Pantalla restauracion de contrasena', screen: const RestaurarPasswordScreen()),
    ScreenDef(route: 'seleccionRegIniScreen', name: 'Pantalla seleccion registro o inicio sesion', screen: const SeleccionRegIniScreen()),
    ScreenDef(route: 'sugerencias', name: 'sugerencias', screen: const SugerenciasScreen()),
    ScreenDef(route: 'wrapper', name: 'Servicio de autenticacion', screen: const Wrapper()),
    ScreenDef(route: 'descripcionSugerencia', name: 'descripcionsugerencia', screen: const SugerenciasDescripcionScreen()),
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