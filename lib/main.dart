import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/auth_provider.dart';
import 'package:timescom/router/app_routes.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AlumnoProvider())
      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimEscom',
      // initialRoute: AppRoutes.initialRoute,
      home: const Wrapper(),
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.darkTheme,
      // onGenerateRoute: ,
    );
  }
}
