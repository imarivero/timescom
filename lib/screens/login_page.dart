import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/register_form_provider.dart';
import 'package:timescom/services/auth_service.dart';
import 'package:timescom/services/notificacions_services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String _email = '';
  // String _password = '';
  @override
  Widget build(BuildContext context) {
    final registroForm = Provider.of<RegisterFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
          children: <Widget>[
            Divider(),
            Center(
              child: Text('Iniciar Sesión',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            _crearEmail(context),
            Divider(),
            _crearPassword(context),
            Divider(),
            Center(
              child: ElevatedButton(
                child: Text('Iniciar Sesión'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.normal),
                  shape: StadiumBorder(),
                ),
                onPressed: () async {
                  // _mostrarAlert();
                  final authservice =
                      Provider.of<AuthService>(context, listen: false);

                  final String? errorMessage = await authservice.LoginUsuario(
                      registroForm.email, registroForm.password);
                  print("$registroForm.email, $registroForm.password");
                  if (errorMessage == null) {
                    Navigator.pushReplacementNamed(context, 'mainMatrizScreen');
                    print("$registroForm.email, $registroForm.password");
                  } else {
                    print(errorMessage);
                    NotificationService.showSnackBar(errorMessage);
                  }

                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearEmail(BuildContext context) {
    final registroForm = Provider.of<RegisterFormProvider>(context);
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Correo electrónico',
          labelText: 'Correo electrónico',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
      onChanged: (value) => registroForm.email = value,
    );
  }

  Widget _crearPassword(BuildContext context) {
    final registroForm = Provider.of<RegisterFormProvider>(context);
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (value) => registroForm.password = value);
  }

  void _mostrarAlert() {
    //print('Sesión inicida');
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Center(
                child: Text(
              'Sesión Iniciada',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //Text('Este es el contenido de la caja de alerta'),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: ElevatedButton(
                      child: Text('Continuar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'mainMatrizScreen');
                      }))
            ],
          );
        });
  }

  void _errorCorreo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Center(
                child: Text(
              'Error: ¡Tu correo no es institucional!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //Text('Este es el contenido de la caja de alerta'),
              ],
            ),
            actions: <Widget>[
              Center(
                  child: ElevatedButton(
                      child: Text('Ingresar de nuevo'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontStyle: FontStyle.normal),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }))
            ],
          );
        });
  }
}
