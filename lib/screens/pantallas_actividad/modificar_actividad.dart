import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/models/actividad.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/tasks_provider.dart';
import 'package:timescom/widgets/widgets.dart';


class ModificarActividadScreen extends StatefulWidget {
   
  const ModificarActividadScreen({Key? key}) : super(key: key);

  @override
  State<ModificarActividadScreen> createState() => _ModificarActividadScreenState();
}

class _ModificarActividadScreenState extends State<ModificarActividadScreen> {

  final GlobalKey<FormState> _myFormKey = GlobalKey();

  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  String idAlumno = '';
  String prioridad = 'Seleccione la prioridad';
  String texto = '';
  bool modificoFecha = false; // para saber si ya se modifico el texto


  DateTime date = DateTime.now();
  DateTime lastDate = DateTime(1);

  final opcionesDropdown = [
    'Urgente + importante',
    'Urgente + no importante',
    'No urgente + importante',
    'No urgente + no importante',
  ];
  
  final Map<String, String> formValues = {};

  _ModificarActividadScreenState(){
    // date.add(const Duration(days: 1));
    lastDate = date.add(const Duration(days: 3650));
  }

  bool realizoCambios(){
    bool bandera = false;
    formValues.forEach((key, value) {
      if(value != ''){
        bandera = true; // Hay cambios
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

  Future<void> modificarActividad(TaskProvider taskProvider, Actividad actividad) async{

    bool exito = await taskProvider.updateActividad(formValues, actividad);

    if(!mounted) return;
    if(exito){await PopMessage.message('Tus cambios se han guardado', context, error: false);}

    int count = 0;
    if(!mounted) return;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  @override
  Widget build(BuildContext context) {

    final Actividad actividad = ModalRoute.of(context)!.settings.arguments as Actividad;

    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    
    idAlumno = alumnoProvider.alumno!.uid;

    // if(actividad.fechaLim == ''){
    //   texto = 'Selecciona una fecha';
    // } else if(actividad.fechaLim != texto){
    //   texto = actividad.fechaLim!;
    // }

    if(!modificoFecha && actividad.fechaLim == ''){
      texto = 'Selecciona una fecha';
    } else if(!modificoFecha){
      texto = actividad.fechaLim!;
    }

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
                  child: Text('Modificar \nactividad', 
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
                  hintText: actividad.titulo,
                  formProperty: 'titulo',
                  formValues: formValues,
                  controller: _tituloController,
                  validator: (value) => RegexConst.validarTituloModificado(value),
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
                  hintText: actividad.descripcion,
                  formProperty: 'descripcion',
                  formValues: formValues,
                  minLines: 5,
                  controller: _descripcionController,
                  validator: (value) => RegexConst.validarDescripcion(value),
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
                          modificoFecha = true;
                          texto = '${date.day}-${date.month}-${date.year}';
                        });

                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: date,
                          lastDate: lastDate
                        );
                        
                        if(newDate != null){
                          setState(() {
                            modificoFecha = true;
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
                        modificoFecha = true;
                        texto = '${date.day}-${date.month}-${date.year}';
                      });
                      
                      CustomDatePicker.showDialogCupertino(
                        CupertinoDatePicker(
                          minimumDate: date,
                          initialDateTime: date,
                          maximumDate: lastDate,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          onDateTimeChanged: (DateTime newDate){
                            setState(() {
                              modificoFecha = true;
                              date = newDate;
                              texto = '${newDate.day}-${newDate.month}-${newDate.year}';
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
                          if(value != null){actividad.prioridad = value as String; formValues['prioridad'] = value;}
                        });
                      },
                      hint: Text(actividad.prioridad, style: GoogleFonts.inter(fontSize: 17, color: Colors.white),),
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

                        print(formValues);
                        await modificarActividad(taskProvider, actividad);
                        
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