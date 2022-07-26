import 'package:flutter/material.dart';

import 'route_transitions.dart';

import '../ui/pages/initial/initial_page.dart';
import '../ui/pages/initial/signin_page.dart';
import '../ui/pages/initial/signup_page.dart';
import '../ui/pages/main/main_page.dart';
import '../ui/pages/profile/profile_page.dart';
import '../ui/pages/profile/profile_update_page.dart';
import '../ui/pages/activity/activity_page.dart';
import '../ui/pages/project/project_page.dart';
import '../ui/pages/note_group/note_group_page.dart';
import '../ui/pages/note/note_page.dart';
import '../ui/pages/task_group/task_group_page.dart';
import '../ui/pages/task/task_page.dart';

class AppRouter {
  static const String initial = 'initial';
  static const String signin = 'signin';
  static const String signup = 'signup';
  static const String main = '/';
  static const String profile = '/profile';
  static const String profileUpdate = '/profileUpdate';
  static const String activity = '/activity';
  static const String project = '/project';
  static const String noteGroup = '/noteGroup';
  static const String note = '/note';
  static const String taskGroup = '/taskGroup';
  static const String task = '/task';

  const AppRouter._();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return NoAnimationRoute(page: const InitialPage());
      case signin:
        return ScaleRoute(page: const SignInPage());
      case signup:
        return FadeRoute(page: const SignUpPage());
      case main:
        return ScaleRoute(page: const MainPage());
      case profile:
        var user = (settings.arguments as Map)['user'];
        return SlideLeftRoute(page: ProfilePage(user: user));
      case profileUpdate:
        var user = (settings.arguments as Map)['user'];
        return FadeRoute(page: ProfileUpdatePage(user: user));
      case activity:
        var activity = (settings.arguments as Map)['activity'];
        return SlideLeftRoute(page: ActivityPage(activity: activity));
      case project:
        var project = (settings.arguments as Map)['project'];
        return SlideLeftRoute(page: ProjectPage(project: project));
      case noteGroup:
        var noteGroup = (settings.arguments as Map)['noteGroup'];
        return SlideLeftRoute(page: NoteGroupPage(noteGroup: noteGroup));
      case note:
        var note = (settings.arguments as Map)['note'];
        return SlideLeftRoute(page: NotePage(note: note));
      case taskGroup:
        var taskGroup = (settings.arguments as Map)['taskGroup'];
        return SlideLeftRoute(page: TaskGroupPage(taskGroup: taskGroup));
      case task:
        var task = (settings.arguments as Map)['task'];
        return SlideLeftRoute(page: TaskPage(task: task));
      default:
        return null;
    }
  }
}
