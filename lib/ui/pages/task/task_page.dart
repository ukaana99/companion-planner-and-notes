import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/task.dart';
import '../../../data/repositories/task_repo.dart';

import '../../../logic/bloc/task/task_bloc.dart';
import '../../../logic/cubit/task/task_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/text_dialog.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/page_header.dart';

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
          PopupMenuItem(value: 0, child: Text('Edit')),
          PopupMenuItem(value: 1, child: Text('Delete')),
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
