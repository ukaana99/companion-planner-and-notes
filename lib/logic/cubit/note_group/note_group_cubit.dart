import 'package:bloc/bloc.dart';
import 'package:companion/data/models/note_group.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/note_group_repo.dart';

part 'note_group_state.dart';

class NoteGroupCubit extends Cubit<NoteGroupState> {
  NoteGroupCubit({
    this.noteGroup,
    required NoteGroupRepository noteGroupRepository,
  })  : _noteGroupRepository = noteGroupRepository,
        super(NoteGroupState(
          noteGroup: noteGroup?? const NoteGroup(),
          title: noteGroup?.title ?? '',
          description: noteGroup?.description ?? '',
          colorHex: noteGroup?.colorHex ?? '0xffffffff',
        ));

  final NoteGroupRepository _noteGroupRepository;
  final NoteGroup? noteGroup;

  void titleChanged(String value) => emit(state.copyWith(title: value));

  void descriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void colorChanged(String value) => emit(state.copyWith(colorHex: value));

  Future<void> submitForm(String userId) async {
    final noteGroup = NoteGroup(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
      userId: userId,
    );
    try {
      await _noteGroupRepository.createNoteGroup(noteGroup);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }

  Future<void> updateForm() async {
    final noteGroup = state.noteGroup?.copyWith(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
    );
    try {
      await _noteGroupRepository.updateNoteGroup(
          state.noteGroup!.id!, noteGroup!);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }
}
