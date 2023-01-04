import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/models/habito.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/habit_provider.dart';
import 'package:timescom/widgets/widgets.dart';


class ModificarHabitoScreen extends StatefulWidget {
   
  const ModificarHabitoScreen({Key? key}) : super(key: key);

  @override
  State<ModificarHabitoScreen> createState() => _ModificarHabitoScreenState();
}

class _ModificarHabitoScreenState extends State<ModificarHabitoScreen> {

  final GlobalKey<FormState> _myFormKey = GlobalKey();

  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  String idAlumno = '';
  String textoHora = '';
  bool modificoHora = false; // para saber si ya se modifico el texto

  final Map<String, String> formValues = {};
  Map<String, bool> diasRepeticion = {};
  final Map<String, dynamic> mapaHabito = {};

  Color color = Colors.red;

  DateTime date = DateTime.now();
  DateTime lastDate = DateTime(1);
  TimeOfDay initTime = TimeOfDay.now();
  
  _ModificarHabitoScreenState(){
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

  Future<void> modificarHabito(HabitProvider habitProvider, Habito oldHabito) async{

    mapaHabito.addAll(formValues);
    mapaHabito['dias_repeticion'] = diasRepeticion;

    bool exito = await habitProvider.updateHabito(mapaHabito, oldHabito);

    if(!mounted) return;
    if(exito){await PopMessage.message('Hábito modificado!', context, error: false);}

    int count = 0;
    if(!mounted) return;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  @override
  Widget build(BuildContext context) {

    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    final habitProvider = Provider.of<HabitProvider>(context);
    
    idAlumno = alumnoProvider.alumno!.uid;

    final Habito habito = ModalRoute.of(context)!.settings.arguments as Habito;

    if(!modificoHora && habito.hora == ''){
      textoHora = 'Selecciona una hora';
    } else if(!modificoHora){
      textoHora = habito.hora!;
    }

    diasRepeticion = habito.diasRepeticion;

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
                  child: Text('Modificación de \nhábito', 
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
                  hintText: habito.titulo,
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
                  hintText: habito.descripcion,
                  formProperty: 'descripcion',
                  formValues: formValues,
                  minLines: 5,
                  controller: _descripcionController,
                  // validator: (value) => RegexConst.validarNombre(value),
                ),
                  
                const SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text('Hora (opcional)', 
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
                        
                        // Cuando lo toca en automatico pone la hora actual
                        setState(() {
                          modificoHora = true;
                          textoHora = '${initTime.hour}:${initTime.minute}';
                          formValues['hora'] = textoHora;
                        });

                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: initTime,
                        );
                        
                        if(newTime != null){
                          setState(() {
                            modificoHora = true;
                            textoHora = '${newTime.hour}:${newTime.minute}';
                            formValues['hora'] = textoHora;
                          });
                        }
                      },
                      child: Text(
                        textoHora,
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

                      // Cuando lo toca en automatico pone la hora actual
                      setState(() {
                        modificoHora = true;
                        textoHora = '${initTime.hour}:${initTime.minute}';
                        formValues['hora'] = textoHora;
                      });
                      
                      CustomDatePicker.showDialogCupertino(
                        CupertinoDatePicker(
                          initialDateTime: date,
                          maximumDate: lastDate,
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: true,
                          onDateTimeChanged: (DateTime newTime) {
                            setState(() {
                              modificoHora = true;
                              textoHora = '${newTime.hour}:${newTime.minute}';
                              formValues['hora'] = textoHora;
                            });
                          },
                        ),
                        context,
                      );
                    },
                    child: Text(
                      textoHora,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 15,),
          
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text('Dias de repetición (opcional)', 
                    style: GoogleFonts.inter(fontSize: 17),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 5,),

                FittedBox(
                  child: Row(
                    children: [

                      _esferaDia('Lu'),
                      _esferaDia('Ma'),
                      _esferaDia('Mi'),
                      _esferaDia('Ju'),
                      _esferaDia('Vi'),
                      _esferaDia('Sa'),
                      _esferaDia('Do'),

                    ],
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
                          await modificarHabito(habitProvider, habito);
                        
                      } else{
                        if(!mounted) return;
                        PopMessage.message('No realizaste ningun cambio', context);
                      }
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    child: const Text('Guardar hábito', style: TextStyle(fontSize: 20),),
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

  Padding _esferaDia(String dia) {

    if(!diasRepeticion[dia]!){
      color = Colors.grey.shade900;
    } else{
      color = Colors.blue;
    }
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // print('hola');
          setState(() {
            if(diasRepeticion[dia]!){
              diasRepeticion[dia] = false;
            } else{
              diasRepeticion[dia] = true;
            }
          });
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(), 
          backgroundColor: color
        ),
        child: Text(
          dia,
          style: const TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}