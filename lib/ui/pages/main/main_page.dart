import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../app/app_theme.dart';
import '../../../logic/cubit/main/main_cubit.dart';

import '../home/home_page.dart';
import '../project/projects_overview.dart';
import '../schedule/schedule_page.dart';

part 'widgets/main_app_bar.dart';
part 'widgets/main_drawer.dart';
part 'widgets/main_bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final pageController = PageController(initialPage: 2);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MainAppBar(scaffoldKey: _scaffoldKey),
      drawer: const MainDrawer(),
      bottomNavigationBar:
          MainBottomNavigationBar(pageController: pageController),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Colors.transparent,
              ]).createShader(bounds),
          blendMode: BlendMode.dstIn,
          child: PageView(
            controller: pageController,
            onPageChanged: (index) => context.read<MainCubit>().setIndex(index),
            children: <Widget>[
              const HomePage(),
              const SchedulePage(),
              const ProjectsOverviewPage(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
