import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../ui/screens/home_screen.dart';
import '../../ui/screens/results_screen.dart';
import '../arguments.dart';
import 'navigator_routes.dart';

/// Inclou la funció [generateRoute] que ens permetrà generar les rutes de
/// navegació de l'App.
class AppRouter {
  ///
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case NavigatorRoutes.home:
        return MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        );

      case NavigatorRoutes.results:

        return MaterialPageRoute(
          builder: (context) {
            return ResultsScreen();
          },
        );

    }
  }
}
