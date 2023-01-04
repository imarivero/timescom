class Habito{

  String titulo;
  String? descripcion;
  String? hora;
  Map<String, bool> diasRepeticion;
  String? idHabito;

  Habito.init({
    required this.titulo,
    required this.diasRepeticion,
  });

  Habito(
    this.titulo,
    this.descripcion,
    this.hora,
    this.diasRepeticion,
    this.idHabito,
  );

  static Habito habitoFromMap(Map<String, dynamic> habitoMap){
    return Habito(
      habitoMap['titulo'] == null ? '' : habitoMap['titulo']!,
      habitoMap['descripcion'] == null ? '' : habitoMap['descripcion']!,
      habitoMap['hora'] == null ? '' : habitoMap['hora']!,
      habitoMap['dias_repeticion'] == null ? '' : habitoMap['dias_repeticion']!,
      habitoMap['id_habito'] == null ? '' : habitoMap['id_habito']!,
    );
  }

  Map<String, dynamic> mapFromHabito(){
    Map<String, dynamic> mapaHabito = {};
    mapaHabito['titulo'] = titulo;
    mapaHabito['descripcion'] = descripcion == null ? '' : descripcion!;
    mapaHabito['hora'] = hora == null ? '' : hora!;
    mapaHabito['dias_repeticion'] = diasRepeticion;
    mapaHabito['id_habito'] = idHabito == null ? '' : idHabito!;

    return mapaHabito;
  }

  void crearHabito(){

  }

  void modificarHabito(){

  }

  void eliminarHabito(){

  }
}