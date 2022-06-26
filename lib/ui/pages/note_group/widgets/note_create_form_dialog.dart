part of '../note_group_page.dart';

class NoteCreateFormDialog extends StatelessWidget {
  const NoteCreateFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteCubit(
        noteRepository: context.read<NoteRepository>(),
      ),
      child: const NoteCreateFormDialogView(),
    );
  }
}

class NoteCreateFormDialogView extends StatelessWidget {
  const NoteCreateFormDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final noteGroup =
        context.select((NoteGroupBloc bloc) => bloc.state.noteGroup);

    return FormDialog(
      title: "New note",
      confirmLabel: "Add",
      onPressed: () =>
          context.read<NoteCubit>().submitForm(user.id!, groupId: noteGroup.id),
      children: [
        const SizedBox(height: 12),
        TextInput(
          hintText: 'Title',
          onChanged: context.read<NoteCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: noteGroup.title,
          hintText: 'Note group',
          enabled: false,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
