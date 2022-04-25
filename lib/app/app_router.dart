import 'package:flutter/material.dart';

import 'route_transitions.dart';

import '../ui/pages/initial/initial_page.dart';
import '../ui/pages/initial/signin_page.dart';
import '../ui/pages/initial/signup_page.dart';
import '../ui/pages/main/main_page.dart';

class AppRouter {
  static const String initial = 'initial';
  static const String signin = 'signin';
  static const String signup = 'signup';
  static const String main = '/';

  const AppRouter._();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return NoAnimationRoute(page: const InitialPage());
      case signin:
        return FadeRoute(page: const SignInPage());
      case signup:
        return FadeRoute(page: const SignUpPage());
      case main:
        return FadeRoute(page: const MainPage());
      default:
        return null;
    }
  }
}
