import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/app_theme.dart';
import '../../../data/models/note.dart';
import '../../../data/repositories/note_repo.dart';
import '../../../logic/cubit/note/note_cubit.dart';

import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/dialog/text_dialog.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/page_item_button.dart';

part 'widgets/note_ocr_dialog.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => NoteCubit(
        noteRepository: context.read<NoteRepository>(),
        note: note,
      ),
      child: const NoteView(),
    );
  }
}

class NoteView extends StatelessWidget {
  const NoteView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((NoteCubit cubit) => cubit.state);
    final contentController = TextEditingController(text: state.content);

    return Scaffold(
      appBar: PageAppBar(
        title: "Note",
        itemBuilder: (context) => const [
          PopupMenuItem(child: Text('Delete'), value: 1),
        ],
        onSelected: (item) async {
          switch (item) {
            case 1:
              await showDialog(
                context: context,
                builder: (_) => TextDialog(
                  title: 'Delete note',
                  description: 'Are you sure to delete this note?',
                  onPressed: () => context
                      .read<NoteRepository>()
                      .deleteNote(state.note!.id!),
                ),
              );
              break;
          }
        },
      ),
      // floatingActionButton: const NoteFab(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: PageItemButton(
          icon: FontAwesomeIcons.solidFileImage,
          title: 'Use OCR',
          onPressed: () => showModalBottomSheet(
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            builder: (_) => BlocProvider.value(
              value: context.read<NoteCubit>(),
              child: const NoteOCRModal(),
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                children: [
                  TextFormField(
                    showCursor: false,
                    initialValue: state.title,
                    maxLength: 32,
                    textAlign: TextAlign.center,
                    onChanged: context.read<NoteCubit>().titleUpdated,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(
                      color: Theme.of(context).textColor,
                      fontSize: 24,
                    ),
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: 'Untitled',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundOverlay,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: TextFormField(
                      controller: contentController,
                      showCursor: false,
                      keyboardType: TextInputType.multiline,
                      minLines: 8,
                      maxLines: null,
                      onChanged: context.read<NoteCubit>().contentUpdated,
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(
                        color: Theme.of(context).textColor,
                        // fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: 'No content...',
                        isDense: true,
                      ),
                    ),
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
