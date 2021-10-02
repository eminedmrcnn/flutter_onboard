class PNGImagePaths {
  static PNGImagePaths? _instace;
  static PNGImagePaths get instance {
    return _instace ??= PNGImagePaths._init();
  }

  PNGImagePaths._init();

  String get foto1 => toPng("foto1");
  String get foto2 => toPng("foto2");
  String get foto3 => toPng("foto3");
  String get hotdogs => toPng('hotdogs');
}

String toPng(String name) => "assets/png/$name.png";
