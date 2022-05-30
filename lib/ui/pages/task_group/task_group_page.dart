import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../../../app/app_theme.dart';
import '../../../data/models/task_group.dart';
import '../../../data/repositories/task_repo.dart';
import '../../../data/repositories/task_group_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/task_group/task_group_bloc.dart';
import '../../../logic/bloc/task_overview/tasks_overview_bloc.dart';
import '../../../logic/cubit/task/task_cubit.dart';
import '../../../logic/cubit/task_group/task_group_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/date_input.dart';
import '../../shared/widgets/dialog/time_input.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/section_container.dart';

part 'widgets/task_group_fab.dart';
part 'widgets/task_group_header.dart';
part 'widgets/task_group_update_form_dialog.dart';
part 'widgets/task_create_form_dialog.dart';

class TaskGroupPage extends StatelessWidget {
  const TaskGroupPage({Key? key, required this.taskGroup}) : super(key: key);

  final TaskGroup taskGroup;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskGroupBloc>(
          lazy: false,
          create: (context) => TaskGroupBloc(
            taskGroupRepository: context.read<TaskGroupRepository>(),
          )..add(TaskGroupSubscriptionRequested(taskGroup.id!)),
        ),
        BlocProvider<TasksOverviewBloc>(
          lazy: false,
          create: (context) => TasksOverviewBloc(
            taskRepository: context.read<TaskRepository>(),
          )..add(TasksOverviewSubscriptionRequested(taskGroup.id!)),
        ),
      ],
      child: const TaskGroupView(),
    );
  }
}

class TaskGroupView extends StatelessWidget {
  const TaskGroupView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskGroup =
        context.select((TaskGroupBloc bloc) => bloc.state.taskGroup);
    final tasks = context.select((TasksOverviewBloc bloc) => bloc.state.tasks);

    return Scaffold(
      appBar: PageAppBar(
        title: "Task Group",
        itemBuilder: (context) => const [
          PopupMenuItem(child: Text('Edit'), value: 0),
        ],
        onSelected: (item) {
          switch (item) {
            case 0:
              showDialog(
                context: context,
                builder: (_) => TaskGroupUpdateFormDialog(taskGroup: taskGroup),
              );
          }
        },
      ),
      floatingActionButton: const TaskGroupOverviewFab(),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            TaskGroupHeader(taskGroup: taskGroup),
            SectionContainer(
              title: 'Tasks',
              child: Column(
                children: tasks
                    .map((task) => _TaskGroupTaskItem(title: task.title!))
                    .toList(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _TaskGroupTaskItem extends StatelessWidget {
  const _TaskGroupTaskItem({
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
