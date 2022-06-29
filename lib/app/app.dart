import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';

import 'app_router.dart';
import 'app_theme.dart';

import '../data/repositories/auth_repo.dart';
import '../data/repositories/user_repo.dart';
import '../data/repositories/activity_repo.dart';
import '../data/repositories/project_repo.dart';
import '../data/repositories/note_repo.dart';
import '../data/repositories/note_group_repo.dart';
import '../data/repositories/task_repo.dart';
import '../data/repositories/task_group_repo.dart';

import '../logic/cubit/theme/theme_cubit.dart';
import '../logic/cubit/internet/internet_cubit.dart';
import '../logic/bloc/app/app_bloc.dart';

class App extends StatelessWidget {
  final Connectivity connectivity;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final ActivityRepository _activityRepository;
  final ProjectRepository _projectRepository;
  final NoteRepository _noteRepository;
  final NoteGroupRepository _noteGroupRepository;
  final TaskRepository _taskRepository;
  final TaskGroupRepository _taskGroupRepository;

  const App({
    Key? key,
    required this.connectivity,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required ActivityRepository activityRepository,
    required ProjectRepository projectRepository,
    required NoteRepository noteRepository,
    required NoteGroupRepository noteGroupRepository,
    required TaskRepository taskRepository,
    required TaskGroupRepository taskGroupRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _activityRepository = activityRepository,
        _projectRepository = projectRepository,
        _noteRepository = noteRepository,
        _noteGroupRepository = noteGroupRepository,
        _taskRepository = taskRepository,
        _taskGroupRepository = taskGroupRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _userRepository),
        RepositoryProvider(create: (context) => _activityRepository),
        RepositoryProvider(create: (context) => _projectRepository),
        RepositoryProvider(create: (context) => _noteRepository),
        RepositoryProvider(create: (context) => _noteGroupRepository),
        RepositoryProvider(create: (context) => _taskRepository),
        RepositoryProvider(create: (context) => _taskGroupRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<InternetCubit>(
              create: (context) => InternetCubit(connectivity: connectivity)),
          BlocProvider<AppBloc>(
            create: (context) =>
                AppBloc(authRepository: _authRepository)..add(AppStarted()),
          ),
        ],
        child: const CompanionApp(),
      ),
    );
  }
}

class CompanionApp extends StatefulWidget {
  const CompanionApp({
    Key? key,
  }) : super(key: key);

  @override
  State<CompanionApp> createState() => _CompanionAppState();
}

class _CompanionAppState extends State<CompanionApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      title: 'Companion Planner and Notes',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: context.select((ThemeCubit cubit) => cubit.state.themeMode),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.initial,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
