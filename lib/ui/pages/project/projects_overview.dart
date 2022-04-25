import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_theme.dart';
import '../../../data/repositories/auth_repo.dart';
import '../../../data/repositories/project_repo.dart';
import '../../../logic/bloc/project_overview/projects_overview_bloc.dart';

class ProjectsOverviewPage extends StatelessWidget {
  const ProjectsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsOverviewBloc(
        authRepository: context.read<AuthRepository>(),
        projectRepository: context.read<ProjectRepository>(),
      )..add(const ProjectsOverviewSubscriptionRequested()),
      child: const ProjectsOverviewView(),
    );
  }
}

class ProjectsOverviewView extends StatelessWidget {
  const ProjectsOverviewView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SizedBox(height: 20),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
