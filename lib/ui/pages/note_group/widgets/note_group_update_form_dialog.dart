part of '../note_group_page.dart';

class NoteGroupUpdateFormDialog extends StatelessWidget {
  const NoteGroupUpdateFormDialog({Key? key, required this.noteGroup})
      : super(key: key);

  final NoteGroup noteGroup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteGroupCubit(
        noteGroupRepository: context.read<NoteGroupRepository>(),
        noteGroup: noteGroup,
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
    final state = context.select((NoteGroupCubit cubit) => cubit.state);

    return FormDialog(
      title: "Edit note group",
      confirmLabel: "Update",
      onPressed: () => context.read<NoteGroupCubit>().updateForm(),
      children: [
        const SizedBox(height: 12),
        TextInput(
          initialValue: state.title,
          hintText: 'Title',
          onChanged: context.read<NoteGroupCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: state.description,
          hintText: 'Description',
          onChanged: context.read<NoteGroupCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(state.colorHex),
          onColorSelected: (color) => context
              .read<NoteGroupCubit>()
              .colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
