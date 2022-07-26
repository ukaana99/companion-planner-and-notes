import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_theme.dart';
import '../../../data/models/project.dart';
import '../../../data/repositories/activity_repo.dart';
import '../../../data/repositories/note_group_repo.dart';
import '../../../data/repositories/project_repo.dart';
import '../../../data/repositories/task_group_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/cubit/note_group/note_group_cubit.dart';
import '../../../logic/cubit/project/project_cubit.dart';
import '../../../logic/bloc/project/project_bloc.dart';

import '../../../logic/cubit/task_group/task_group_cubit.dart';
import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/text_dialog.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/page_item_button.dart';
import '../../shared/widgets/section_container.dart';

part 'widgets/project_update_form_dialog.dart';
part 'widgets/task_group_create_form_dialog.dart';
part 'widgets/note_group_create_form_dialog.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ProjectBloc(
        projectRepository: context.read<ProjectRepository>(),
        activityRepository: context.read<ActivityRepository>(),
        taskGroupRepository: context.read<TaskGroupRepository>(),
        noteGroupRepository: context.read<NoteGroupRepository>(),
      )
        ..add(ProjectSubscriptionRequested(project.id!))
        ..add(ProjectActivitiesSubscriptionRequested(project.id!))
        ..add(ProjectTaskGroupsSubscriptionRequested(project.id!))
        ..add(ProjectNoteGroupsSubscriptionRequested(project.id!)),
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
    final project = context.select((ProjectBloc bloc) => bloc.state.project);

    return Scaffold(
      appBar: PageAppBar(
        title: "Project",
        itemBuilder: (context) => const [
          PopupMenuItem(value: 0, child: Text('Edit')),
          PopupMenuItem(value: 1, child: Text('Delete')),
        ],
        onSelected: (item) async {
          switch (item) {
            case 0:
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ProjectUpdateFormDialog(project: project),
              );
              break;
            case 1:
              await showDialog(
                context: context,
                builder: (_) => TextDialog(
                  title: 'Delete project',
                  description: 'Are you sure to delete this project?',
                  onPressed: () {
                    context
                        .read<ProjectRepository>()
                        .deleteProject(project.id!);
                  },
                ),
              );
              break;
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
            PageHeader(
              title: project.title,
              description: project.description,
              color: colorFromString(project.colorHex!),
            ),
            const SectionContainer(
                title: 'Activities', child: _ProjectActivities()),
            const SectionContainer(
                title: 'Task groups', child: _ProjectTaskGroups()),
            const SectionContainer(
                title: 'Note groups', child: _ProjectNoteGroups()),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ProjectActivities extends StatelessWidget {
  const _ProjectActivities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities =
        context.select((ProjectBloc bloc) => bloc.state.activities);

    return Column(
      children: [
        for (var activity in activities)
          _ProjectActivityItem(title: activity.title!),
      ],
    );
  }
}

class _ProjectTaskGroups extends StatelessWidget {
  const _ProjectTaskGroups({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskGroups =
        context.select((ProjectBloc bloc) => bloc.state.taskGroups);

    return Column(
      children: [
        for (var taskGroup in taskGroups)
          _ProjectTaskItem(title: taskGroup.title!),
        PageItemButton(
          icon: FontAwesomeIcons.clipboardList,
          title: 'New task',
          onPressed: () => showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<ProjectBloc>(),
              child: const TaskGroupCreateFormDialog(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectNoteGroups extends StatelessWidget {
  const _ProjectNoteGroups({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteGroups =
        context.select((ProjectBloc bloc) => bloc.state.noteGroups);

    return Column(
      children: [
        for (var noteGroup in noteGroups)
          _ProjectNoteItem(title: noteGroup.title!),
        PageItemButton(
          icon: FontAwesomeIcons.solidClipboard,
          title: 'New note',
          onPressed: () => showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<ProjectBloc>(),
              child: const NoteGroupCreateFormDialog(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectActivityItem extends StatelessWidget {
  const _ProjectActivityItem({
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
      child: SizedBox.expand(
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).textColor),
        ),
      ),
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
      child: SizedBox.expand(
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).textColor),
        ),
      ),
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
      child: SizedBox.expand(
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).textColor),
        ),
      ),
    );
  }
}
