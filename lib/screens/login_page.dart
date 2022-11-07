import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
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
            _crearEmail(),
            Divider(),
            _crearPassword(),
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
                onPressed: () {
                  _mostrarAlert();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Correo electrónico',
          labelText: 'Correo electrónico',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
      onChanged: (String valor) async {
        //if()
      },
    );
  }

  Widget _crearPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _password = valor;
            }));
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
                        Navigator.of(context).pop();
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
