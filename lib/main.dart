import 'package:flutter/material.dart';
import 'package:timescom/router/app_routes.dart';
import 'package:timescom/screens/auth/main_screen.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
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
      home: const MainScreen(),
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.darkTheme,
      // onGenerateRoute: ,
    );
  }
}
