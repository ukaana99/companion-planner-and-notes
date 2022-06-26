import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/note.dart';
import '../../../data/repositories/note_repo.dart';

part 'notes_overview_event.dart';
part 'notes_overview_state.dart';

class NotesOverviewBloc extends Bloc<NotesOverviewEvent, NotesOverviewState> {
  NotesOverviewBloc({
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(const NotesOverviewState()) {
    on<NotesOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<NotesOverviewNoteDeleted>(_onNoteDeleted);
    on<NotesOverviewAllNotesDeleted>(_onAllNotesDeleted);
    on<NotesOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final NoteRepository _noteRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status:  NotesOverviewStatus.loading));

    await emit.forEach<List<Note>>(
      _noteRepository.getNotesByGroupId(event.groupId),
      onData: (notes) => state.copyWith(
        status:  NotesOverviewStatus.success,
        notes:  notes,
      ),
      onError: (_, __) => state.copyWith(
        status:  NotesOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onNoteDeleted(event, emit) async {
    emit(state.copyWith(lastDeletedNote: event.note));
    await _noteRepository.deleteNote(event.note.id);
  }

  Future<void> _onAllNotesDeleted(event, emit) async {
    await _noteRepository.deleteNotesByGroupId(event.groupId);
  }

  Future<void> _onUndoDeletionRequested(event, emit) async {
    assert(
      state.lastDeletedNote != null,
      'Last deleted note can not be null.',
    );

    final note = state.lastDeletedNote!;
    emit(state.copyWith(lastDeletedNote:  null));
    await _noteRepository.createNote(note);
  }
}
