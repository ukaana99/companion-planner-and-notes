import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../../../app/app_theme.dart';
import '../../../app/app_router.dart';
import '../../../data/models/project.dart';
import '../../../data/repositories/project_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/cubit/project/project_cubit.dart';
import '../../../logic/bloc/project_overview/projects_overview_bloc.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/no_data_placeholder.dart';
import '../../shared/widgets/dialog/form_dialog.dart';

part 'widgets/projects_overview_fab.dart';
part 'widgets/project_create_form_dialog.dart';
part 'widgets/project_item.dart';

class ProjectsOverviewPage extends StatelessWidget {
  const ProjectsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocProvider(
      lazy: false,
      create: (context) => ProjectsOverviewBloc(
        projectRepository: context.read<ProjectRepository>(),
      )..add(ProjectsOverviewSubscriptionRequested(user.id!)),
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
    final state = context.select((ProjectsOverviewBloc bloc) => bloc.state);

    return Scaffold(
      floatingActionButton: const ProjectsOverviewFab(),
      body: state.projects.isEmpty
          ? SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(top: kToolbarHeight * 2),
                  child: NoDataPlaceholder(
                    Theme.of(context).brightness == Brightness.light
                        ? 'assets/svg/project_1.svg'
                        : 'assets/svg/project_2.svg',
                    title: 'No project available',
                    description: 'Try creating a new project first',
                    isLoading: state.status == ProjectsOverviewStatus.loading,
                  ),
                ),
              ),
            )
          : ListView(
              children: [
                const SizedBox(height: 8),
                for (var project in state.projects) ProjectListTile(project),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}
