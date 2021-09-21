class SVGImagePaths {
  static SVGImagePaths? _instace;
  static SVGImagePaths get instance {
    return _instace ??= SVGImagePaths._init();
  }

  SVGImagePaths._init();

  String get foto1 => toSVG("foto1");
  String get foto2 => toSVG("foto2");
  String get foto3 => toSVG("foto3");
}

String toSVG(String name) => "assets/svg/$name.svg";
