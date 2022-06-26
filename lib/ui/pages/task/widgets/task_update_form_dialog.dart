part of '../task_page.dart';

class TaskUpdateFormDialog extends StatelessWidget {
  const TaskUpdateFormDialog({Key? key, required this.task})
      : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(
        taskRepository: context.read<TaskRepository>(),
        task: task,
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
    final state = context.select((TaskCubit cubit) => cubit.state);

    return FormDialog(
      title: "Edit task group",
      confirmLabel: "Update",
      onPressed: () => context.read<TaskCubit>().updateForm(),
      children: [
        const SizedBox(height: 12),
        TextInput(
          initialValue: state.title,
          hintText: 'Title',
          onChanged: context.read<TaskCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: state.description,
          hintText: 'Description',
          onChanged: context.read<TaskCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(state.colorHex),
          onColorSelected: (color) => context
              .read<TaskCubit>()
              .colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
