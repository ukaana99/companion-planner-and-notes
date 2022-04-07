import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';

import 'app_router.dart';
import 'app_theme.dart';
import '../logic/cubit/theme_cubit.dart';
import '../logic/cubit/internet_cubit.dart';

class App extends StatelessWidget {
  final Connectivity connectivity;

  const App({
    Key? key,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<InternetCubit>(
          lazy: false,
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
        ),
      ],
      child: const CompanionApp(),
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          context.select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.initial,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
