import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timescom/helpers/regex_const.dart';
import 'package:timescom/providers/alumno_provider.dart';
import 'package:timescom/providers/habit_provider.dart';
import 'package:timescom/widgets/widgets.dart';


class CrearHabitoScreen extends StatefulWidget {
   
  const CrearHabitoScreen({Key? key}) : super(key: key);

  @override
  State<CrearHabitoScreen> createState() => _CrearHabitoScreenState();
}

class _CrearHabitoScreenState extends State<CrearHabitoScreen> {

  final GlobalKey<FormState> _myFormKey = GlobalKey();

  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  String idAlumno = '';
  String textoHora = 'Selecciona una hora';

  final Map<String, String> formValues = {};
  final Map<String, bool> diasRepeticion = {
    'Lu': false,
    'Ma': false,
    'Mi': false,
    'Ju': false,
    'Vi': false,
    'Sa': false,
    'Do': false,
  };
  final Map<String, dynamic> mapaHabito = {};

  Color color = Colors.red;

  DateTime date = DateTime.now();
  DateTime lastDate = DateTime(1);
  TimeOfDay initTime = TimeOfDay.now();
  
  _CrearHabitoScreenState(){
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

  Future<void> crearHabito(HabitProvider habitProvider) async{

    mapaHabito.addAll(formValues);
    mapaHabito['dias_repeticion'] = diasRepeticion;

    bool exito = await habitProvider.addHabito(mapaHabito);

    if(!mounted) return;
    if(exito){await PopMessage.message('Hábito registrado!', context, error: false);}

    if(!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final alumnoProvider = Provider.of<AlumnoProvider>(context);
    final habitProvider = Provider.of<HabitProvider>(context);
    
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
                  child: Text('Registro de \nhábito', 
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
                  hintText: 'Título del hábito',
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
                  hintText: 'Descripción del hábito',
                  formProperty: 'descripcion',
                  formValues: formValues,
                  minLines: 5,
                  controller: _descripcionController,
                  validator: (value) => RegexConst.validarDescripcion(value),
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
                          textoHora = '${initTime.hour}:${initTime.minute}';
                          formValues['hora'] = textoHora;
                        });

                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: initTime,
                        );
                        
                        if(newTime != null){
                          setState(() {
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
                          await crearHabito(habitProvider);
                        
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