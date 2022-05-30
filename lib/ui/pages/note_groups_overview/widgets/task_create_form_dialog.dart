part of '../task_groups_overview_page.dart';

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
    final taskGroups = context.select((TaskGroupsOverviewBloc bloc) => bloc.state.taskGroups);

    return FormDialog(
      title: "New task",
      confirmLabel: "Add",
      onPressed: () => context.read<TaskCubit>().submitForm(user.id!),
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
        SelectionInput(
          hintText: 'Task group',
          items: taskGroups
              .map((taskGroup) => DropdownMenuItem(value: taskGroup.id, child: Text(taskGroup.title!)))
              .toList(),
          onChanged: context.read<TaskCubit>().groupIdChanged,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
