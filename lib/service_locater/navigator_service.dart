import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(String routeName, {dynamic params}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: params);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
