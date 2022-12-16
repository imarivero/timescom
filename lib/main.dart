import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/register_form_provider.dart';
import 'package:timescom/router/app_routes.dart';
import 'package:timescom/screens/slideshowpage.dart';
import 'package:timescom/services/auth_service.dart';
import 'package:timescom/services/notificacions_services.dart';
import 'package:timescom/services/sugerencia_service.dart';
import 'package:timescom/theme/app_theme.dart';

void main() => runApp(AppsState());

class AppsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HabitsSugerenciasService(),
        )
      ],
      child: MyApp(),
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
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.darkTheme,
      scaffoldMessengerKey: NotificationService.messengerKey,
    );
  }
}
