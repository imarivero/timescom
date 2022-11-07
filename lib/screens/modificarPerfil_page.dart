import 'package:flutter/material.dart';

class ModificarPerfil extends StatefulWidget {
  ModificarPerfil({Key? key}) : super(key: key);

  @override
  State<ModificarPerfil> createState() => _ModificarPerfilState();
}

class _ModificarPerfilState extends State<ModificarPerfil> {
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          children: <Widget>[
            Center(
              child: Text(
                'Modificar datos',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            _modificarNombre(),
            Divider(),
            _modificarApellidoP(),
            Divider(),
            _modificarApellidoM(),
            Divider(),
            _email(),
            // Divider(),
            // _actualPassword(),
            Divider(),
            _crearPassword(),
            Divider(),
            _confirmacionPassword(),
            Divider(),
            Center(
              child: ElevatedButton(
                child: Text(
                  'Modificar Datos',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.normal),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  //_mostrarAlert();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _modificarNombre() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 2)),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        //helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
      ),
    );
  }

  Widget _modificarApellidoP() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 2)),
        hintText: 'Nombre de la persona',
        labelText: 'Apellido Paterno',
        //helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
      ),
    );
  }

  Widget _modificarApellidoM() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 2)),
        hintText: 'Nombre de la persona',
        labelText: 'Apellido Materno',
        //helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
      ),
    );
  }

  Widget _email() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 2)),
          hintText: 'Correo electrónico',
          labelText: 'Correo electrónico',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
      onChanged: (String valor) async {
        //if()
      },
    );
  }

  Widget _actualPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(width: 2)),
            hintText: 'Contraseña',
            labelText: 'Contraseña actual',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _password = valor;
            }));
  }

  Widget _crearPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(width: 2)),
            hintText: 'Contraseña',
            labelText: 'Contraseña nueva',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _password = valor;
            }));
  }

  Widget _confirmacionPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(width: 2)),
            hintText: 'Contraseña',
            labelText: 'Confirmación contraseña',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _password = valor;
            }));
  }
}
