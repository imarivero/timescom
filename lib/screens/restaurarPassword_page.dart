import 'package:flutter/material.dart';

class RestaurarPassword extends StatefulWidget {
  RestaurarPassword({Key? key}) : super(key: key);

  @override
  State<RestaurarPassword> createState() => _RestaurarPasswordState();
}

class _RestaurarPasswordState extends State<RestaurarPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        //backgroundColor: Colors.black,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text('Restaurar contraseña',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40, color: Colors.black)),
                  )),
              Container(
                  margin: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Text(
                      'Ingresa tu correo electrónico al cual será enviada la restauración de tu contraseña',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  )),

              //Padding(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0)
              Divider(),
              _crearEmail(),
              Divider(),
              Center(
                child: ElevatedButton(
                  child: Text('Restaurar contraseña'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal),
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    _mostrarAlert();
                  },
                ),
              )
            ],
          )),
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
              'Se ha enviado la restauración de la contraseña a tu correo electrónico',
              textAlign: TextAlign.center,
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
                      child: Text('Ok'),
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
