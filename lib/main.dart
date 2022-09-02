import 'package:flutter/material.dart';
import 'package:timescom/router/app_routes.dart';
import 'package:timescom/theme/app_theme.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimEscom',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.darkTheme,
      // onGenerateRoute: ,
    );
  }
}
