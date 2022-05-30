import 'package:companion/ui/shared/widgets/section_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_theme.dart';
import '../../../data/models/project.dart';
import '../../../data/repositories/project_repo.dart';
import '../../../logic/cubit/project/project_cubit.dart';
import '../../../logic/bloc/project/project_bloc.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/dialog/form_dialog.dart';

part 'widgets/project_header.dart';
part 'widgets/project_update_form_dialog.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ProjectBloc(
        projectRepository: context.read<ProjectRepository>(),
      )..add(ProjectSubscriptionRequested(project.id!)),
      child: const ProjectView(),
    );
  }
}

class ProjectView extends StatelessWidget {
  const ProjectView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((ProjectBloc bloc) => bloc.state);

    return Scaffold(
      appBar: PageAppBar(
        title: "Project",
        itemBuilder: (context) => const [
          PopupMenuItem(child: Text('Edit'), value: 0),
        ],
        onSelected: (item) {
          switch (item) {
            case 0:
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ProjectUpdateFormDialog(project: state.project),
              );
          }
        },
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            ProjectHeader(project: state.project),
            const SectionContainer(title: 'Tasks', child: _ProjectTasks()),
            const SectionContainer(title: 'Notes', child: _ProjectNotes()),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ProjectTasks extends StatelessWidget {
  const _ProjectTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ProjectTaskItem(title: 'Task 1'),
        _ProjectTaskItem(title: 'Task 2'),
      ],
    );
  }
}

class _ProjectNotes extends StatelessWidget {
  const _ProjectNotes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ProjectNoteItem(title: 'Note 1'),
        _ProjectNoteItem(title: 'Note 2'),
      ],
    );
  }
}

class _ProjectTaskItem extends StatelessWidget {
  const _ProjectTaskItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundOverlay,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SizedBox.expand(child: Text(title)),
    );
  }
}

class _ProjectNoteItem extends StatelessWidget {
  const _ProjectNoteItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundOverlay,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SizedBox.expand(child: Text(title)),
    );
  }
}
