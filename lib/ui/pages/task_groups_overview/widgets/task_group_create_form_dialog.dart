part of '../task_groups_overview_page.dart';

class TaskGroupCreateFormDialog extends StatelessWidget {
  const TaskGroupCreateFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskGroupCubit(
        taskGroupRepository: context.read<TaskGroupRepository>(),
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
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final selectedColor =
        context.select((TaskGroupCubit cubit) => cubit.state.colorHex);

    return FormDialog(
      title: "New task group",
      confirmLabel: "Add",
      onPressed: () => context.read<TaskGroupCubit>().submitForm(user.id!),
      children: [
        const SizedBox(height: 12),
        TextInput(
          hintText: 'Title',
          onChanged: context.read<TaskGroupCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          hintText: 'Description',
          onChanged: context.read<TaskGroupCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(selectedColor),
          onColorSelected: (color) => context
              .read<TaskGroupCubit>()
              .colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
