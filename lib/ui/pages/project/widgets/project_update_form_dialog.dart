part of '../project_page.dart';

class ProjectUpdateFormDialog extends StatelessWidget {
  const ProjectUpdateFormDialog({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectCubit(
        projectRepository: context.read<ProjectRepository>(),
        project: project,
      ),
      child: const ProjectUpdateFormDialogView(),
    );
  }
}

class ProjectUpdateFormDialogView extends StatelessWidget {
  const ProjectUpdateFormDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((ProjectCubit cubit) => cubit.state);

    return FormDialog(
      title: "Edit project",
      confirmLabel: "Update",
      onPressed: () => context.read<ProjectCubit>().updateForm(),
      children: [
        const SizedBox(height: 12),
        TextInput(
          initialValue: state.title,
          hintText: 'Title',
          onChanged: context.read<ProjectCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: state.coordinator,
          hintText: 'Coordinator',
          onChanged: context.read<ProjectCubit>().coordinatorChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: state.description,
          hintText: 'Description',
          onChanged: context.read<ProjectCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(state.colorHex),
          onColorSelected: (color) =>
              context.read<ProjectCubit>().colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
