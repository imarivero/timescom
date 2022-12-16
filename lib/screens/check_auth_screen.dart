import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/screens/main_matriz_screen.dart';
import 'package:timescom/screens/slideshowpage.dart';
import 'package:timescom/services/auth_service.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authservice.leerToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            Future.microtask(
              () async {
                final resp = await authservice.leerToken();
                if (resp != '' && resp != null) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => MainMatrizScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SlideShowPage1(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                }
              },
            );
            return Container();
          },
        ),
      ),
    );
  }
}
