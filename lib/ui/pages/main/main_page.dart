import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/repositories/user_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/user/user_bloc.dart';
import '../../../logic/cubit/main/main_cubit.dart';

import '../home/home_page.dart';
import '../projects_overview/projects_overview_page.dart';
import '../schedule/schedule_page.dart';
import '../note_groups_overview/note_groups_overview_page.dart';
import '../task_groups_overview/task_groups_overview_page.dart';

part 'widgets/main_app_bar.dart';
part 'widgets/main_drawer.dart';
part 'widgets/main_bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.user.isEmpty) {
          Navigator.of(context).pushReplacementNamed(AppRouter.signin);
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MainCubit>(create: (context) => MainCubit()),
          BlocProvider<UserBloc>(
            lazy: false,
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: const MainView(),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    if (user.isNotEmpty) {
      context.read<UserBloc>().add(UserSubscriptionRequested(user.id!));
    }

    final scaffoldKey = GlobalKey<ScaffoldState>();
    final pageController = PageController(initialPage: 1);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MainAppBar(scaffoldKey: scaffoldKey),
      drawer: MainDrawer(pageController: pageController),
      bottomNavigationBar:
          MainBottomNavigationBar(pageController: pageController),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: PageView(
          controller: pageController,
          onPageChanged: (index) => context.read<MainCubit>().setIndex(index),
          children: const [
            HomePage(),
            SchedulePage(),
            ProjectsOverviewPage(),
            TaskGroupsOverviewPage(),
            NoteGroupsOverviewPage(),
          ],
        ),
      ),
    );
  }
}
