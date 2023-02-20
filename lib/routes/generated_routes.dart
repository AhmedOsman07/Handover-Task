import 'package:flutter/material.dart';

import '../ui/home/home_screen.dart';

class GenerateRoutes {
  static MaterialPageRoute _goTo(Widget screen, settings) =>
      MaterialPageRoute(settings: settings, builder: (context) => screen);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic>? args =
        settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case HomeScreen.routeName:
        return _goTo(const HomeScreen(), settings);

      default:
        return _goTo(const HomeScreen(), settings);
    }
  }
}
