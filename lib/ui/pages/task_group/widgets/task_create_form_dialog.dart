part of '../task_group_page.dart';

class TaskCreateFormDialog extends StatelessWidget {
  const TaskCreateFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(
        taskRepository: context.read<TaskRepository>(),
      ),
      child: const TaskCreateFormDialogView(),
    );
  }
}

class TaskCreateFormDialogView extends StatelessWidget {
  const TaskCreateFormDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final deadline = context.select((TaskCubit cubit) => cubit.state.deadline);
    final taskGroup =
        context.select((TaskGroupBloc bloc) => bloc.state.taskGroup);
    final tasks = context.select((TasksOverviewBloc bloc) => bloc.state.tasks);
    final total = tasks.length;
    var completed = tasks.where((i) => i.isCompleted!).toList().length;

    return FormDialog(
      title: "New task",
      confirmLabel: "Add",
      onPressed: () {
        context.read<TaskCubit>().submitForm(user.id!, groupId: taskGroup.id);
        context.read<TaskGroupBloc>().add(
              TaskGroupTaskGroupCompletionUpdated(
                taskGroup: taskGroup,
                total: total + 1,
                completed: completed,
              ),
            );
      },
      children: [
        const SizedBox(height: 12),
        TextInput(
          hintText: 'Title',
          onChanged: context.read<TaskCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          hintText: 'Description',
          onChanged: context.read<TaskCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            DateInput(
              hintText: 'Date',
              value: deadline,
              onChanged: context.read<TaskCubit>().deadlineChanged,
            ),
            const SizedBox(width: 8),
            TimeInput(
              hintText: 'Time',
              value: deadline,
              onChanged: context.read<TaskCubit>().deadlineChanged,
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: taskGroup.title,
          hintText: 'Task group',
          enabled: false,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
