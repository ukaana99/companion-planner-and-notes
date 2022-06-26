import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/models/task.dart';
import '../../../data/models/task_group.dart';
import '../../../data/repositories/task_repo.dart';
import '../../../data/repositories/task_group_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/task_group/task_group_bloc.dart';
import '../../../logic/bloc/tasks_overview/tasks_overview_bloc.dart';
import '../../../logic/cubit/task/task_cubit.dart';
import '../../../logic/cubit/task_group/task_group_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/date_input.dart';
import '../../shared/widgets/dialog/text_dialog.dart';
import '../../shared/widgets/dialog/time_input.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/page_item_button.dart';
import '../../shared/widgets/section_container.dart';

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

  Color getCompletionColor(int completion) {
    var red = (completion > 50 ? 1 - 2 * (completion - 50) / 100.0 : 1.0) * 255;
    var green = (completion > 50 ? 1.0 : 2 * completion / 100.0) * 191;
    Color result = Color.fromARGB(255, red.toInt(), green.toInt(), 0);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final taskGroup =
        context.select((TaskGroupBloc bloc) => bloc.state.taskGroup);
    final tasks = context.select((TasksOverviewBloc bloc) => bloc.state.tasks);
    final pendingTasks = tasks.where((i) => !i.isCompleted!).toList();
    final completedTasks = tasks.where((i) => i.isCompleted!).toList();

    return Scaffold(
      appBar: PageAppBar(
        title: "Task Group",
        itemBuilder: (context) => const [
          PopupMenuItem(child: Text('Edit'), value: 0),
          PopupMenuItem(child: Text('Delete'), value: 1),
        ],
        onSelected: (item) async {
          switch (item) {
            case 0:
              showDialog(
                context: context,
                builder: (_) => TaskGroupUpdateFormDialog(taskGroup: taskGroup),
              );
              break;
            case 1:
              await showDialog(
                context: context,
                builder: (_) => TextDialog(
                  title: 'Delete task group',
                  description: 'Are you sure to delete this task group?',
                  onPressed: () {
                    context
                        .read<TasksOverviewBloc>()
                        .add(TasksOverviewAllTasksDeleted(taskGroup.id!));
                    context
                        .read<TaskGroupRepository>()
                        .deleteTaskGroup(taskGroup.id!);
                  },
                ),
              );
              break;
          }
        },
      ),
      // floatingActionButton: const TaskGroupOverviewFab(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: PageItemButton(
          icon: FontAwesomeIcons.plus,
          title: 'Add new task',
          onPressed: () => showDialog(
            context: context,
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: context.read<TaskGroupBloc>()),
                BlocProvider.value(value: context.read<TasksOverviewBloc>()),
              ],
              child: const TaskCreateFormDialog(),
            ),
          ),
        ),
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            PageHeader(
              title: taskGroup.title,
              description: taskGroup.description,
              color: colorFromString(taskGroup.colorHex!),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: 48,
              decoration: BoxDecoration(
                color: getCompletionColor(taskGroup.completion!),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(
                child: Text(
                  '${taskGroup.completion}%',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            pendingTasks.isEmpty
                ? Container()
                : SectionContainer(
                    title: 'Pending Tasks',
                    child: Column(
                      children: [
                        for (var task in pendingTasks) _TaskItem(task: task),
                      ],
                    ),
                  ),
            completedTasks.isEmpty
                ? Container()
                : SectionContainer(
                    title: 'Completed Tasks',
                    child: Column(
                      children: [
                        for (var task in completedTasks) _TaskItem(task: task),
                      ],
                    ),
                  ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final taskGroup =
        context.select((TaskGroupBloc bloc) => bloc.state.taskGroup);
    final tasks = context.select((TasksOverviewBloc bloc) => bloc.state.tasks);
    final total = tasks.length;
    final completed = tasks.where((i) => i.isCompleted!).toList().length;
    context.read<TaskGroupBloc>().add(
          TaskGroupTaskGroupCompletionUpdated(
            taskGroup: taskGroup,
            total: total,
            completed: completed,
          ),
        );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(context, AppRouter.task,
            arguments: {'task': task}),
        onLongPress: () {
          context.read<TasksOverviewBloc>().add(
                TasksOverviewTaskCompletionToggled(
                  task: task,
                  isCompleted: !task.isCompleted!,
                ),
              );
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundOverlay,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: SizedBox.expand(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      task.title!.isNotEmpty ? task.title! : 'Untitled',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).textColor,
                        decoration: task.isCompleted!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('dd/MM/yyyy').format(task.deadline!),
                    style: TextStyle(
                        color: task.deadline!.isBefore(DateTime.now()) &&
                                !task.isCompleted!
                            ? Colors.red
                            : null),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
