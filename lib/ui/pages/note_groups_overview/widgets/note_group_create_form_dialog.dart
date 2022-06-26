part of '../note_groups_overview_page.dart';

class NoteGroupCreateFormDialog extends StatelessWidget {
  const NoteGroupCreateFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteGroupCubit(
        noteGroupRepository: context.read<NoteGroupRepository>(),
      ),
      child: const NoteGroupCreateFormDialogView(),
    );
  }
}

class NoteGroupCreateFormDialogView extends StatelessWidget {
  const NoteGroupCreateFormDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final selectedColor =
        context.select((NoteGroupCubit cubit) => cubit.state.colorHex);

    return FormDialog(
      title: "New note group",
      confirmLabel: "Add",
      onPressed: () => context.read<NoteGroupCubit>().submitForm(user.id!),
      children: [
        const SizedBox(height: 12),
        TextInput(
          hintText: 'Title',
          onChanged: context.read<NoteGroupCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          hintText: 'Description',
          onChanged: context.read<NoteGroupCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(selectedColor),
          onColorSelected: (color) => context
              .read<NoteGroupCubit>()
              .colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
