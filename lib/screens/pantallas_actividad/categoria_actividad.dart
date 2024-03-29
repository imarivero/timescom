import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/models/actividad.dart';
import 'package:timescom/models/categoria.dart';
import 'package:timescom/providers/providers.dart';
import 'package:timescom/theme/app_theme.dart';
import 'package:timescom/widgets/widgets.dart';

class CategoriaActividad extends StatefulWidget{
  
  const CategoriaActividad({Key? key}) : super(key: key);

  @override
  State<CategoriaActividad> createState() => _CategoriaActividadState();
}

class _CategoriaActividadState extends State<CategoriaActividad> with TickerProviderStateMixin{

  List<Actividad> listaActividadGeneral = [];
  Map<int, bool> isCheckedMap = {};
  Map<Actividad, int> actIndex = {};


  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );
  late final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
  late final Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

  Future<void> completarActividad(
    Actividad actividad, 
    TaskProvider taskProvider, 
    RegistrosProvider registrosProvider) async {

    await Future.delayed(const Duration(milliseconds: 1200));
    taskProvider.eliminarActividad(actividad);
    listaActividadGeneral.remove(actividad);

    // Asegura que las actividades que sigan sin completar despues
    // de redibujar por ultima vez se mantengan en false
    for (int i = 0; i < listaActividadGeneral.length; i++) {
      isCheckedMap[i] = false;
      actIndex[listaActividadGeneral[i]] = i;
    }

    registrosProvider.actualizarRegistroCategoria('actividad');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    RegistrosProvider registrosProvider = Provider.of<RegistrosProvider>(context);

    final Categoria categoria = ModalRoute.of(context)!.settings.arguments as Categoria;
    IconData icon = Icons.abc;
    Color color = Colors.red;

    switch (categoria.titulo) {
      case 'todas':
        listaActividadGeneral = taskProvider.listActividades;
        icon = FontAwesomeIcons.exclamation;
        color = Colors.lightBlue;
        break;
      case 'urgente+importante':
        listaActividadGeneral = taskProvider.listActividadesUrgIm;
        icon = FontAwesomeIcons.exclamation;
        color = Colors.red;
        break;
      case 'urgente+noimportante':
        listaActividadGeneral = taskProvider.listActividadesUrgNim;
        icon = FontAwesomeIcons.bolt;
        color = Colors.yellow.shade900;
        break;
      case 'nourgente+importante':
        listaActividadGeneral = taskProvider.listActividadesNurgIm;
        icon = FontAwesomeIcons.bath;
        color = Colors.purple;
        break;
      case 'nourgente+noimportante':
        listaActividadGeneral = taskProvider.listActividadesNurgNim;
        icon = FontAwesomeIcons.basketball;
        color = Colors.green.shade700;
        break;
      default:
        print('error seleccion de tipo');
        break;
    }

    if(isCheckedMap.isEmpty || actIndex.isEmpty){
      for (int i = 0; i < listaActividadGeneral.length; i++) {
        isCheckedMap[i] = false;
        actIndex[listaActividadGeneral[i]] = i;
      }
    } else{
      
      actIndex.clear();

      for (int i = 0; i < listaActividadGeneral.length; i++) {
        actIndex[listaActividadGeneral[i]] = i;
      }
    }

    // print('reconstruyendo..');

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
              child: Text(categoria.descripcion, 
                style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold)
              )
            ),

            const SizedBox(height: 40,),

            if(listaActividadGeneral.isNotEmpty)
              ListView.builder(
                itemCount: listaActividadGeneral.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _ActividadHabitoCard(
                    icon: icon, 
                    color: color, 
                    actividad: listaActividadGeneral[index],
                    index: actIndex[listaActividadGeneral[index]]!, // index tiene que ser el original y no el de listbuilder
                    isCheckedMap: isCheckedMap,
                    onTap: (actividad) async {
                      isCheckedMap[index] = true; // revisar
                      setState(() => {}); // redibujar
                      await completarActividad(actividad, taskProvider, registrosProvider);
                    } ,
                  );
                },
              ),
            
            if(listaActividadGeneral.isEmpty)
              const Center(
                child: Text('Aún no has agregado ninguna actividad aquí', textAlign: TextAlign.center,)
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

class _ActividadHabitoCard extends StatefulWidget {

  final IconData icon;
  final Color color;
  final Actividad actividad;
  final Function(Actividad actividad) onTap;
  final int index;
  final Map<int, bool> isCheckedMap;
  
  const _ActividadHabitoCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.actividad, 
    required this.onTap, 
    required this.index, 
    required this.isCheckedMap, 
  }) : super(key: key);

  @override
  State<_ActividadHabitoCard> createState() => _ActividadHabitoCardState();
}

class _ActividadHabitoCardState extends State<_ActividadHabitoCard> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: GestureDetector(
        onTap: () {

          Navigator.pushNamed(context, 'detalleActividad', arguments: widget.actividad);
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
                  color: widget.color,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(widget.icon),
              ),
      
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.actividad.titulo,
                    style: GoogleFonts.inter(fontSize: 16, ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
      
              Checkbox(
                fillColor: MaterialStateProperty.all<Color>(AppTheme.primary),
                shape: const CircleBorder(),
                value: widget.isCheckedMap[widget.index], 
                // value: isCheckedList[widget.index], 
                onChanged: (value) async{

                  widget.isCheckedMap[widget.index] = value ?? false;

                  // Callback a la funcion del widget padre
                  widget.onTap(widget.actividad);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}