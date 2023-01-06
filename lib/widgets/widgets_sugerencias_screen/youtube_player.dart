import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerSugerencia extends StatefulWidget {
  final String urlvideoHabito;
  const YoutubePlayerSugerencia({super.key, required this.urlvideoHabito});

  @override
  State<YoutubePlayerSugerencia> createState() =>
      _YoutubePlayerSugerenciaState();
}

class _YoutubePlayerSugerenciaState extends State<YoutubePlayerSugerencia> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videourl = widget.urlvideoHabito;
    final videoId = YoutubePlayer.convertUrlToId(videourl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        )
      ],
    );
  }
}
