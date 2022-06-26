import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/task_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/task/task_bloc.dart';
import '../../../logic/bloc/tasks_overview/tasks_overview_bloc.dart';
import '../../../logic/cubit/task/task_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/date_input.dart';
import '../../shared/widgets/dialog/text_dialog.dart';
import '../../shared/widgets/dialog/time_input.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/section_container.dart';

part 'widgets/task_update_form_dialog.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => TaskBloc(
        taskRepository: context.read<TaskRepository>(),
      )..add(TaskSubscriptionRequested(task.id!)),
      child: const TaskView(),
    );
  }
}

class TaskView extends StatelessWidget {
  const TaskView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = context.select((TaskBloc bloc) => bloc.state.task);

    return Scaffold(
      appBar: PageAppBar(
        title: "Task",
        itemBuilder: (context) => const [
          PopupMenuItem(child: Text('Edit'), value: 0),
          PopupMenuItem(child: Text('Delete'), value: 1),
        ],
        onSelected: (item) async {
          switch (item) {
            case 0:
              showDialog(
                context: context,
                builder: (_) => TaskUpdateFormDialog(task: task),
              );
              break;
            case 1:
              await showDialog(
                context: context,
                builder: (_) => TextDialog(
                  title: 'Delete task',
                  description: 'Are you sure to delete this task?',
                  onPressed: () =>
                      context.read<TaskRepository>().deleteTask(task.id!),
                ),
              );
              break;
          }
        },
      ),
      // floatingActionButton: const TaskOverviewFab(),

      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            PageHeader(
              title: task.title,
              description: task.description,
              color: colorFromString(task.colorHex!),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
