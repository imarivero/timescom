import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/providers/providers.dart';
import 'package:timescom/widgets/widgets.dart';

class MainMatrizScreen extends StatefulWidget {
   
  const MainMatrizScreen({Key? key}) : super(key: key);

  @override
  State<MainMatrizScreen> createState() => _MainMatrizScreenState();
}

class _MainMatrizScreenState extends State<MainMatrizScreen> with TickerProviderStateMixin{

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );

  late final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
  
  late final Animation<double> _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context){

    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final habitProvider = Provider.of<HabitProvider>(context);
    final registrosProvider = Provider.of<RegistrosProvider>(context);

    // Comprueba si ya esta abierta la sesion y se trae los datos de nuevo
    if(authProvider.userAuth != null && alumnoProvider.alumno!.nombre == ''){
      alumnoProvider.getAlumnoInfo(authProvider.alumnoLogedPreviously()!);
      taskProvider.getActividades(authProvider.userAuth!.uid);
      habitProvider.getHabitos(authProvider.userAuth!.uid);
      registrosProvider.getRegistros(authProvider.userAuth!.uid);
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(child: CustomDrawer(),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              // Menu control y texto
              _MenuDrawerText(scaffoldKey: scaffoldKey),
            
              // Saludo y nombre de alumno
              const SizedBox(height: 20,),
              Text('Hola, \n ${alumnoProvider.alumno!.nombre} ${alumnoProvider.alumno!.apellidoPaterno}',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold)),
            
              // Tarjetas actividades y habitos
              const CardRow(),
            
              // Texto y matriz
              const CardTable(),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButtons(animation: _animation, animationController: _animationController,),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _MenuDrawerText extends StatelessWidget {
  const _MenuDrawerText({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(Icons.menu, color: Colors.white, size: 30,),
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          Text('Inicio', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

