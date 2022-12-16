import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/widgets/youtube_player.dart';

import '../services/sugerencia_service.dart';

class SugerenciaImage extends StatelessWidget {
  const SugerenciaImage({super.key, this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    final habitosugerencia = Provider.of<HabitsSugerenciasService>(context);
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 40),
        child: Container(
          decoration: _BuildBoxDecoration(),
          width: double.infinity,
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: YoutubePlayerSugerencia(
                urlvideoHabito: habitosugerencia.habitoSeleccionado.videourl),
          ),
        ));
  }

  BoxDecoration _BuildBoxDecoration() => BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);
}
