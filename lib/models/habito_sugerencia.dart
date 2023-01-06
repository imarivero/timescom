import 'dart:convert';

class HabitoSugerencia {
  HabitoSugerencia(
      {required this.descripcion,
      this.imagenurl,
      required this.titulo,
      required this.videourl,
      this.id});

  String descripcion;
  String? imagenurl;
  String titulo;
  String? id;
  String videourl;

  factory HabitoSugerencia.fromJson(String str) =>
      HabitoSugerencia.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HabitoSugerencia.fromMap(Map<String, dynamic> json) =>
      HabitoSugerencia(
        descripcion: json["descripcion"],
        imagenurl: json["imagenurl"],
        titulo: json["titulo"],
        videourl: json["videourl"],
      );

  Map<String, dynamic> toMap() => {
        "descripcion": descripcion,
        "imagenurl": imagenurl,
        "titulo": titulo,
      };

  HabitoSugerencia copy() => HabitoSugerencia(
      titulo: titulo,
      descripcion: descripcion,
      imagenurl: imagenurl,
      id: id,
      videourl: videourl);
}
