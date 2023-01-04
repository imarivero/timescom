import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/models/habito.dart';
import 'package:timescom/providers/providers.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/widgets.dart';

class CategoriaHabito extends StatefulWidget{
  
  const CategoriaHabito({Key? key}) : super(key: key);

  @override
  State<CategoriaHabito> createState() => _CategoriaHabitoState();
}

class _CategoriaHabitoState extends State<CategoriaHabito> with TickerProviderStateMixin{

  List<Habito> listaHabitos = [];

  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );
  late final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
  late final Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

  @override
  Widget build(BuildContext context) {

    HabitProvider habitProvider = Provider.of<HabitProvider>(context);

    IconData icon = Icons.recycling;
    Color color = Colors.red;


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
              child: Text('Todos tus hábitos', 
                style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 40,),

            if(habitProvider.listHabitos.isNotEmpty)
              ListView.builder(
                itemCount: habitProvider.listHabitos.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _ActividadHabitoCard(icon: icon, color: color, habito: habitProvider.listHabitos[index]);
                },
              ),
            
            if(habitProvider.listHabitos.isEmpty)
              const Center(
                child: Text('Aún no has agregado ningún hábito', textAlign: TextAlign.center,)
              ),

           
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

  final IconData icon;
  final Color color;
  final Habito habito;
  
  const _ActividadHabitoCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.habito,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'detalleHabito', arguments: habito);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
      
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    habito.titulo,
                    style: GoogleFonts.inter(fontSize: 16, ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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