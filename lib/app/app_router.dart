import 'package:flutter/material.dart';

import 'route_transitions.dart';

import '../ui/screens/initial/initial_view.dart';
import '../ui/screens/home/home_view.dart';

class AppRouter {
  static const String initial = 'initial';
  static const String login = 'login';
  static const String register = 'register';
  static const String home = '/';

  const AppRouter._();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return NoAnimationRoute(page: const InitialView());
      case login:
        return null;
      case register:
        return null;
      case home:
        return ScaleRoute(page: const HomeView());
      default:
        return null;
    }
  }
}
