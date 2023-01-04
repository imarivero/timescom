import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/tasks_provider.dart';
import 'package:timescom/widgets/widgets.dart';


class CrearActividadScreen extends StatefulWidget {
   
  const CrearActividadScreen({Key? key}) : super(key: key);

  @override
  State<CrearActividadScreen> createState() => _CrearActividadScreenState();
}

class _CrearActividadScreenState extends State<CrearActividadScreen> {

  final GlobalKey<FormState> _myFormKey = GlobalKey();

  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  String idAlumno = '';
  String texto = 'Selecciona una fecha';

  final opcionesDropdown = [
    'Urgente + importante',
    'Urgente + no importante',
    'No urgente + importante',
    'No urgente + no importante',
  ];

  final Map<String, String> formValues = {};

  DateTime date = DateTime.now();
  DateTime lastDate = DateTime(1);



  _CrearActividadScreenState(){
    // date.add(const Duration(days: 1));
    lastDate = date.add(const Duration(days: 3650));
  }

  bool realizoCambios(){
    bool bandera = false;
    formValues.forEach((key, value) {
      if(value != ''){
        bandera = true;
        return; // rompe el ciclo
      }
    });
    return bandera;
  }

  bool validarPrioridad(){
    if(formValues.containsKey('prioridad')){
      return true;
    }
    return false;
  }

  Future<void> crearActividad(TaskProvider taskProvider) async{

    bool exito = await taskProvider.addActividad(formValues);
    // bool exito = await taskProvider.addActividad(formValues, idAlumno);

    if(!mounted) return;
    if(exito){await PopMessage.message('Actividad registrada!', context, error: false);}

    if(!mounted) return;
    Navigator.pop(context);
  }

  String prioridad = 'Seleccione la prioridad';

  @override
  Widget build(BuildContext context) {

    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    
    idAlumno = alumnoProvider.alumno!.uid;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _myFormKey,
          child: SingleChildScrollView(
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
                  child: Text('Registro de \nactividad', 
                    style: GoogleFonts.inter(fontSize: 35, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  )
                ),
                  
                const SizedBox(height: 40,),
          
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text('Título', 
                    style: GoogleFonts.inter(fontSize: 17),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
                
                CustomInputTextField(
                  hintText: 'Título de la actividad',
                  formProperty: 'titulo',
                  formValues: formValues,
                  controller: _tituloController,
                  validator: (value) => RegexConst.validarTitulo(value),
                ),
                  
                const SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text('Descripción', 
                    style: GoogleFonts.inter(fontSize: 17),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
                
                CustomInputTextField(
                  hintText: 'Descripción de la actividad',
                  formProperty: 'descripcion',
                  formValues: formValues,
                  minLines: 5,
                  controller: _descripcionController,
                  // validator: (value) => RegexConst.validarNombre(value),
                ),
                  
                const SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text('Fecha límite (opcional)', 
                    style: GoogleFonts.inter(fontSize: 17),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
          
                if(Platform.isAndroid)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextButton(
                      onPressed: () async{
                        
                        // Cuando lo toca en automatico pone la fecha de hoy
                        setState(() {
                          texto = '${date.day}-${date.month}-${date.year}';
                          formValues['fecha_limite'] = texto;
                        });

                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: date,
                          lastDate: lastDate
                        );
                        
                        if(newDate != null){
                          setState(() {
                            texto = '${newDate.day}-${newDate.month}-${newDate.year}';
                            formValues['fecha_limite'] = texto;
                          });
                        }
                      },
                      child: Text(
                        texto,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                
                if(Platform.isIOS)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextButton(
                    onPressed: (){

                      // Cuando lo toca en automatico pone la fecha de hoy
                      setState(() {
                        texto = '${date.day}-${date.month}-${date.year}';
                      });
                      
                      CustomDatePicker.showDialogCupertino(
                        CupertinoDatePicker(
                          initialDateTime: date,
                          maximumDate: lastDate,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              date = newDate;
                              texto = '${date.day}-${date.month}-${date.year}';
                              formValues['fecha_limite'] = texto;
                            });
                          },
                        ),
                        context,
                      );
                    },
                    child: Text(
                      texto,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text('Cuadrante de prioridad', 
                    style: GoogleFonts.inter(fontSize: 17),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
          
                const SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      border: Border.all(color: Colors.black,),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      items: opcionesDropdown.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          if(value != null){prioridad = value as String; formValues['prioridad'] = value;}
                        });
                      },
                      hint: Text(prioridad, style: GoogleFonts.inter(fontSize: 17, color: Colors.white),),
                    ),
                  ),
                ),
          
                const SizedBox(height: 30,),
          
                Center(
                  child: ElevatedButton(
                    onPressed: () async{
                      FocusScope.of(context).requestFocus(FocusNode()); // esconde teclado
                      if(realizoCambios()){
                        if(!_myFormKey.currentState!.validate()){
                        //   print('Formulario no valido');
                          return;
                        }

                        if(formValues.containsKey('prioridad')){
                          print(formValues);
                          await crearActividad(taskProvider);
                        } else{
                          PopMessage.message('No has seleccionado la prioridad', context);
                        }
                        
                      } else{
                        if(!mounted) return;
                        PopMessage.message('No realizaste ningun cambio', context);
                      }
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    child: const Text('Guardar actividad', style: TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}