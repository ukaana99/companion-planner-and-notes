import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';

import 'app_router.dart';
import 'app_theme.dart';

import '../data/repositories/auth_repo.dart';
import '../data/repositories/project_repo.dart';

import '../logic/cubit/theme/theme_cubit.dart';
import '../logic/cubit/internet/internet_cubit.dart';
import '../logic/cubit/main/main_cubit.dart';
import '../logic/bloc/app/app_bloc.dart';

class App extends StatelessWidget {
  final Connectivity connectivity;
  final AuthRepository _authRepository;
  final ProjectRepository _projectRepository;

  const App({
    Key? key,
    required this.connectivity,
    required AuthRepository authRepository,
    required ProjectRepository projectRepository,
  })  : _authRepository = authRepository,
        _projectRepository = projectRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _projectRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<InternetCubit>(
            lazy: false,
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<MainCubit>(
            lazy: false,
            create: (context) => MainCubit(),
          ),
          BlocProvider<AppBloc>(
            lazy: false,
            create: (context) => AppBloc(authRepository: _authRepository),
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
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
