import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timescom/models/categoria.dart';
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
            _ActividadCard(titulo: 'Sacar al perron', icon: Icons.bolt, color: Colors.blue,),
            _ActividadCard(titulo: 'Sacar al perron', icon: Icons.bolt, color: Colors.blue,),
            _ActividadCard(titulo: 'Sacar al perron', icon: Icons.bolt, color: Colors.blue,),

          ],
        ),
      ),
      floatingActionButton: CustomFloatingButtons(animation: animation, animationController: animationController,),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _ActividadCard extends StatelessWidget {

  // TODO: Reemplazar por el modelo generalizado de actividad con las peticiones
  final String titulo;
  final IconData icon;
  final Color color;

  const _ActividadCard({
    Key? key,
    required this.titulo,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
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
    );
  }
}