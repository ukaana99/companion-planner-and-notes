import 'package:flutter/material.dart';

import 'route_transitions.dart';

import '../ui/pages/initial/initial_page.dart';
import '../ui/pages/initial/signin_page.dart';
import '../ui/pages/initial/signup_page.dart';
import '../ui/pages/main/main_page.dart';
import '../ui/pages/project/project_page.dart';
import '../ui/pages/task_group/task_group_page.dart';

class AppRouter {
  static const String initial = 'initial';
  static const String signin = 'signin';
  static const String signup = 'signup';
  static const String main = '/';
  static const String project = '/project';
  static const String taskGroup = '/taskGroup';

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
      case project:
        var project = (settings.arguments as Map)['project'];
        return SlideLeftRoute(page: ProjectPage(project: project));
      case taskGroup:
        var taskGroup = (settings.arguments as Map)['taskGroup'];
        return SlideLeftRoute(page: TaskGroupPage(taskGroup: taskGroup));
      default:
        return null;
    }
  }
}
