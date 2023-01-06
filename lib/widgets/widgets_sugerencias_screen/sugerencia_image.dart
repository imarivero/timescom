import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timescom/widgets/widgets_sugerencias_screen/youtube_player.dart';
import 'package:timescom/providers/sugerencia_service.dart';

class SugerenciaImage extends StatelessWidget {
  const SugerenciaImage({super.key, this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    final habitosugerencia = Provider.of<HabitsSugerenciasService>(context);
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
        child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          height: 250,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: YoutubePlayerSugerencia(
                urlvideoHabito: habitosugerencia.habitoSeleccionado.videourl),
          ),
        ));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          borderRadius: const BorderRadius.only(
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
