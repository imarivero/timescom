import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/models/alumno.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/auth_provider.dart';
import 'package:timescom/screens/screens.dart';

class Wrapper extends StatelessWidget {

  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return StreamBuilder(
      stream: authProvider.user,
      builder: (context, AsyncSnapshot<Alumno?>snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final Alumno? alumno = snapshot.data;
          return alumno == null ? const WelcomeScreen() : const MainMatrizScreen();
        } else{
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

// class Wrapper extends StatefulWidget {

//   const Wrapper({super.key});

//   @override
//   State<Wrapper> createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     return StreamBuilder(
//       stream: authProvider.user,
//       builder: (context, AsyncSnapshot<Alumno?>snapshot) {
//         if(snapshot.connectionState == ConnectionState.active){
//           final Alumno? alumno = snapshot.data;
//           return alumno == null ? const WelcomeScreen() : const MainMatrizScreen();
//         } else{
//           return const Scaffold(body: Center(child: CircularProgressIndicator()));
//         }
//       },
//     );
//   }

//   // @override
//   // void didChangeDependencies() {
//   //   Provider.of<AuthProvider>(context).user!.listen((alumno) {
//   //     if(alumno == null){
//   //       Navigator.pushReplacementNamed(context, 'loginScreen');
//   //     } else{
//   //       Navigator.pushReplacementNamed(context, 'mainMatrizScreen');
//   //     }
//   //   });
//   //   super.didChangeDependencies();
//   // }
// }
