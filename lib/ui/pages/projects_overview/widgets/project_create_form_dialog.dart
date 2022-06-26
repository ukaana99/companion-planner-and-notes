part of '../projects_overview_page.dart';

class ProjectCreateFormDialog extends StatelessWidget {
  const ProjectCreateFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectCubit(
        projectRepository: context.read<ProjectRepository>(),
      ),
      child: const ProjectCreateFormDialogView(),
    );
  }
}

class ProjectCreateFormDialogView extends StatelessWidget {
  const ProjectCreateFormDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final state = context.select((ProjectCubit cubit) => cubit.state);

    return FormDialog(
      title: "New project",
      confirmLabel: "Add",
      onPressed: () {
        context.read<ProjectCubit>().submitForm(user.id!);
        
      },
      children: [
        const SizedBox(height: 12),
        TextInput(
          hintText: 'Title',
          onChanged: context.read<ProjectCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          hintText: 'Coordinator',
          onChanged: context.read<ProjectCubit>().coordinatorChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
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
