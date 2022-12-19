import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timescom/widgets/slideshow.dart';
import 'package:timescom/screens/bienvenido.dart';

class SlideShowPage1 extends StatelessWidget {
  const SlideShowPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SlideShow(
          bulletPrimario: 20,
          bulletSecundario: 12,
          //!color botones
          colorprimario: Colors.blue,
          colorsecundario: Colors.red,
          slides: <Widget>[
            _slide(
                Texto: "Bienvenido a TimEscom", svg: 'assets/svgs/slide-6.svg'),
            _slide(
                Texto: "Una gran herramienta para tu dia a dia",
                svg: 'assets/svgs/slide-2.svg'),
            _slide(
                Texto: "La mejor ayuda de estudiantes para estudiantes",
                svg: 'assets/svgs/slide-3.svg'),
            _slide(
                Texto: "Tu mundo en nunca fue tan facil",
                svg: 'assets/svgs/slide-4.svg'),
            _slide(
                Texto: "Dejanos ayudarte a cumplir tus sueños",
                svg: 'assets/svgs/slide-5.svg'),
            WelcomeScreen(),
          ],
        ));
  }
}

class _slide extends StatelessWidget {
  final String svg;
  final String Texto;
  const _slide({
    Key? key,
    required this.Texto,
    required this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              Texto,
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 500,
            child: SvgPicture.asset(svg),
          ),
        ],
      ),
    );
  }
}
