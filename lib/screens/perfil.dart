import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(25)),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Perfil",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 90,
                      ),
                      Text(
                        "Nombre del estudiante",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "<Correo>",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'ModificarPerfil');
                        },
                        child: Text("Modificar INFORMACION"),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Eliminar Cuenta",
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
