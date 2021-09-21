import 'package:flutter/material.dart';
import 'package:flutter_architecture/view/deneme.dart';



import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.denem:
        return normalNavigate(Deneme());

      default:
    }
    return MaterialPageRoute(builder: (context) => Deneme());
  }

  MaterialPageRoute normalNavigate(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
}