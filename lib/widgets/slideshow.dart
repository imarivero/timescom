import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final bool puntosArribas;
  final List<Widget> slides;
  final Color colorprimario;
  final Color colorsecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  const SlideShow(
      {super.key,
      required this.slides,
      this.puntosArribas = false,
      this.colorprimario = Colors.blue,
      this.colorsecundario = Colors.grey,
      required this.bulletPrimario,
      required this.bulletSecundario});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => new _SlidesShowModel(),
      child: SafeArea(
        child: Center(child: Builder(builder: (BuildContext context) {
          Provider.of<_SlidesShowModel>(context)._colorprimario =
              this.colorprimario;

          Provider.of<_SlidesShowModel>(context)._colorSecundario =
              this.colorsecundario;
          Provider.of<_SlidesShowModel>(context)._bulletPrimario =
              this.bulletPrimario;
          Provider.of<_SlidesShowModel>(context)._bulletSecundario =
              this.bulletSecundario;

          return _CrearEstrcturaSlideshow(
              puntosArribas: puntosArribas, slides: slides);
        })),
      ),
    );
  }
}

class _CrearEstrcturaSlideshow extends StatelessWidget {
  const _CrearEstrcturaSlideshow({
    Key? key,
    required this.puntosArribas,
    required this.slides,
  }) : super(key: key);

  final bool puntosArribas;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (this.puntosArribas)
          _Dots(
            totalSlides: this.slides.length,
          ),
        Expanded(
          child: Slides(this.slides),
        ),
        if (!this.puntosArribas)
          _Dots(
            totalSlides: this.slides.length,
          ),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots({
    super.key,
    required this.totalSlides,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            totalSlides,
            (i) => dot(
                  index: i,
                )),
      ),
    );
  }
}

class dot extends StatelessWidget {
  final int index;

  const dot({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlidesShowModel>(context);
    double tam;
    Color colortemp;
    if (ssModel.currentPage >= index - 0.5 &&
        ssModel.currentPage < index + 0.5) {
      tam = ssModel.bulletPrimario;
      colortemp = ssModel._colorprimario;
    } else {
      tam = ssModel._bulletSecundario;
      colortemp = ssModel._colorSecundario;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: tam,
      height: tam,
      decoration: BoxDecoration(
        color: colortemp,
        shape: BoxShape.circle,
      ),
    );
  }
}

class Slides extends StatefulWidget {
  final List<Widget> slides;
  const Slides(this.slides);

  @override
  State<Slides> createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  //el page controller me ayuda a saber el estado de mi pageview
  final pageviewcontroller = new PageController();

  @override
  void initState() {
    super.initState();
    pageviewcontroller.addListener(() {
      //actualizar el provider

      Provider.of<_SlidesShowModel>(context, listen: false).currentPage =
          pageviewcontroller.page!;
    });
  }

//el dispose es usado para evitar fugas de memoria
  @override
  void dispose() {
    pageviewcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageviewcontroller,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlidesShowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorprimario = Colors.blue;
  Color _colorSecundario = Colors.grey;
  double _bulletPrimario = 12;
  double _bulletSecundario = 12;

  double get currentPage => this._currentPage;

  set currentPage(double valorActual) {
    this._currentPage = valorActual;
    notifyListeners();
  }

  Color get colorPrimario => this._colorprimario;

  set colorPrimario(Color color) {
    this._colorprimario = color;
    notifyListeners();
  }

  Color get colorSecundario => this._colorSecundario;

  set colorSecundariop(Color color) {
    this._colorSecundario = color;
    notifyListeners();
  }

  double get bulletPrimario => this._bulletPrimario;

  set bulletprimario(double tam) {
    this._bulletPrimario = tam;
    notifyListeners();
  }

  double get bulletSecundario => this._bulletSecundario;

  set bulletSecundario(double tam) {
    this._bulletSecundario = tam;
    notifyListeners();
  }
}
