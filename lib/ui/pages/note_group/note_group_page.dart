import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/models/note.dart';
import '../../../data/models/note_group.dart';
import '../../../data/repositories/note_repo.dart';
import '../../../data/repositories/note_group_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/note_group/note_group_bloc.dart';
import '../../../logic/bloc/notes_overview/notes_overview_bloc.dart';
import '../../../logic/cubit/note/note_cubit.dart';
import '../../../logic/cubit/note_group/note_group_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/text_dialog.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/page_item_button.dart';
import '../../shared/widgets/section_container.dart';

part 'widgets/note_group_update_form_dialog.dart';
part 'widgets/note_create_form_dialog.dart';

class NoteGroupPage extends StatelessWidget {
  const NoteGroupPage({Key? key, required this.noteGroup}) : super(key: key);

  final NoteGroup noteGroup;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteGroupBloc>(
          lazy: false,
          create: (context) => NoteGroupBloc(
            noteGroupRepository: context.read<NoteGroupRepository>(),
          )..add(NoteGroupSubscriptionRequested(noteGroup.id!)),
        ),
        BlocProvider<NotesOverviewBloc>(
          lazy: false,
          create: (context) => NotesOverviewBloc(
            noteRepository: context.read<NoteRepository>(),
          )..add(NotesOverviewSubscriptionRequested(noteGroup.id!)),
        ),
      ],
      child: const NoteGroupView(),
    );
  }
}

class NoteGroupView extends StatelessWidget {
  const NoteGroupView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteGroup =
        context.select((NoteGroupBloc bloc) => bloc.state.noteGroup);
    final notes = context.select((NotesOverviewBloc bloc) => bloc.state.notes);

    return Scaffold(
      appBar: PageAppBar(
        title: "Note Group",
        itemBuilder: (context) => const [
          PopupMenuItem(value: 0, child: Text('Edit')),
          PopupMenuItem(value: 1, child: Text('Delete')),
        ],
        onSelected: (item) async {
          switch (item) {
            case 0:
              showDialog(
                context: context,
                builder: (_) => NoteGroupUpdateFormDialog(noteGroup: noteGroup),
              );
              break;
            case 1:
              await showDialog(
                context: context,
                builder: (_) => TextDialog(
                  title: 'Delete note group',
                  description: 'Are you sure to delete this note group?',
                  onPressed: () {
                    context
                        .read<NotesOverviewBloc>()
                        .add(NotesOverviewAllNotesDeleted(noteGroup.id!));
                    context
                        .read<NoteGroupRepository>()
                        .deleteNoteGroup(noteGroup.id!);
                  },
                ),
              );
              break;
          }
        },
      ),
      // floatingActionButton: const NoteGroupsOverviewFab(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: PageItemButton(
          icon: FontAwesomeIcons.plus,
          title: 'Add new note',
          onPressed: () => showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<NoteGroupBloc>(),
              child: const NoteCreateFormDialog(),
            ),
          ),
        ),
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            PageHeader(
              title: noteGroup.title,
              description: noteGroup.description,
              color: colorFromString(noteGroup.colorHex!),
            ),
            notes.isEmpty
                ? Container()
                : SectionContainer(
                    title: 'Notes',
                    child: Column(
                      children: [
                        for (var note in notes)
                          _NoteItem(
                            note: note,
                          ),
                      ],
                    ),
                  ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(context, AppRouter.note,
            arguments: {'note': note}),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundOverlay,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: SizedBox.expand(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                note.title!.isNotEmpty ? note.title! : 'Untitled',
                style: TextStyle(color: Theme.of(context).textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
