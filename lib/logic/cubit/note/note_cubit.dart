import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:companion/data/models/note.dart';
import 'package:equatable/equatable.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/note_repo.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit({
    this.note,
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(NoteState(
          note: note ?? const Note(),
          title: note?.title ?? '',
          content: note?.content ?? '',
          groupId: note?.groupId ?? '',
        ));

  final NoteRepository _noteRepository;
  final Note? note;
  Timer? _debounce;

  void titleChanged(String value) => emit(state.copyWith(title: value));

  void imageChanged(XFile? value) => emit(state.copyWith(image: value));

  void scannedTextChanged(String? value) =>
      emit(state.copyWith(scannedText: value));

  Future<void> processImage() async {
    final inputImage = InputImage.fromFilePath(state.image!.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    final text = recognizedText.text;
    emit(state.copyWith(scannedText: text));
  }

  void addScannedText() {
    contentUpdated(
        '${state.content.isEmpty ? '' : state.content + '\n'}${state.scannedText}');
    scannedTextChanged('');
  }

  Future<void> submitForm(String userId, {String? groupId}) async {
    final note = Note(
      title: state.title,
      content: state.content,
      groupId: groupId ?? state.groupId,
    );
    try {
      await _noteRepository.createNote(note);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }

  void titleUpdated(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final note = state.note?.copyWith(
        title: value,
      );
      try {
        unawaited(_noteRepository.updateNote(state.note!.id!, note!));
        emit(state.copyWith(title: value));
      } catch (_) {}
    });
  }

  void contentUpdated(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final note = state.note?.copyWith(
        content: value,
      );
      try {
        unawaited(_noteRepository.updateNote(state.note!.id!, note!));
        emit(state.copyWith(content: value));
      } catch (_) {}
    });
  }
}
