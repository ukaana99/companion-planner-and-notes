part of '../task_group_page.dart';

class TaskGroupUpdateFormDialog extends StatelessWidget {
  const TaskGroupUpdateFormDialog({Key? key, required this.taskGroup})
      : super(key: key);

  final TaskGroup taskGroup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskGroupCubit(
        taskGroupRepository: context.read<TaskGroupRepository>(),
        taskGroup: taskGroup,
      ),
      child: const TaskGroupCreateFormDialogView(),
    );
  }
}

class TaskGroupCreateFormDialogView extends StatelessWidget {
  const TaskGroupCreateFormDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((TaskGroupCubit cubit) => cubit.state);

    return FormDialog(
      title: "Edit task group",
      confirmLabel: "Update",
      onPressed: () => context.read<TaskGroupCubit>().updateForm(),
      children: [
        const SizedBox(height: 12),
        TextInput(
          initialValue: state.title,
          hintText: 'Title',
          onChanged: context.read<TaskGroupCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: state.description,
          hintText: 'Description',
          onChanged: context.read<TaskGroupCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(state.colorHex),
          onColorSelected: (color) => context
              .read<TaskGroupCubit>()
              .colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
