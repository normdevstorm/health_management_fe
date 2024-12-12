import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  String? previousRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    this.previousRoute = previousRoute?.settings.name;
    print('Current route: ${route.settings.name}, Previous route: $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    this.previousRoute = previousRoute?.settings.name;
    print('Current route: ${route.settings.name}, Previous route: $previousRoute');
  }
}