import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/models/actividad.dart';
import 'package:timescom/models/categoria.dart';
import 'package:timescom/models/habito.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/widgets.dart';

class DetalleCategoriaScreen extends StatefulWidget{
  
  const DetalleCategoriaScreen({Key? key}) : super(key: key);

  @override
  State<DetalleCategoriaScreen> createState() => _DetalleCategoriaScreenState();
}

class _DetalleCategoriaScreenState extends State<DetalleCategoriaScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {

    final Categoria categoria = ModalRoute.of(context)!.settings.arguments as Categoria;

    late final AnimationController animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    late final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    
    late final Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    Map<String, bool> diasRepeticion = {
      'Lunes': true,
      'Martes': false,
    };

    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Icon(Icons.arrow_back_ios_new),
            ),

            Center(
              child: Text(categoria.titulo, 
                style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 40,),

            // TODO: Cambiar por un list builder
            _ActividadHabitoCard(objeto: Actividad(prioridad: 1, titulo: 'Hola'),icon: Icons.bolt, color: Colors.blue,),
            _ActividadHabitoCard(objeto: Habito(titulo: 'Hábito de prueba', diasRepeticion: diasRepeticion),icon: Icons.bolt, color: Colors.blue,),
            _ActividadHabitoCard(objeto: Actividad(prioridad: 1, titulo: 'Hola2') ,icon: Icons.bolt, color: Colors.blue,),

          ],
        ),
      ),
      floatingActionButton: CustomFloatingButtons(animation: animation, animationController: animationController,),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _ActividadHabitoCard extends StatelessWidget {

  // TODO: Reemplazar por el modelo generalizado de actividad con las peticiones
  final IconData icon;
  final Color color;
  final Object objeto;
  Actividad? actividad;
  Habito? habito;
  
  _ActividadHabitoCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.objeto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String titulo = '';

    // Verifica de que tipo es el objeto que entro
    if(objeto is Actividad){
      actividad = objeto as Actividad;
      titulo = actividad!.titulo;
    }else{
      habito = objeto as Habito;
      titulo = habito!.titulo;
    }

    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: GestureDetector(
        onTap: () {
          if(objeto is Actividad){
            Navigator.pushNamed(context, 'detalleActividad', arguments: actividad);
          }else{
            Navigator.pushNamed(context, 'detalleHabito', arguments: habito);
          }
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            border: Border.all(color: Colors.black,),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
      
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(icon),
              ),
      
              Text(
                titulo,
                style: GoogleFonts.inter(fontSize: 16, )
              ),
      
              Checkbox(
                fillColor: MaterialStateProperty.all<Color>(AppTheme.primary),
                shape: const CircleBorder(),
                value: false, 
                onChanged: (value){
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}