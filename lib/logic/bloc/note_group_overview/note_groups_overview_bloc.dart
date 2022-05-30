import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/note_group.dart';
import '../../../data/repositories/note_group_repo.dart';

part 'note_groups_overview_event.dart';
part 'note_groups_overview_state.dart';

class NoteGroupsOverviewBloc
    extends Bloc<NoteGroupsOverviewEvent, NoteGroupsOverviewState> {
  NoteGroupsOverviewBloc({
    required NoteGroupRepository noteGroupRepository,
  })  : _noteGroupRepository = noteGroupRepository,
        super(const NoteGroupsOverviewState()) {
    on<NoteGroupsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<NoteGroupsOverviewNoteGroupDeleted>(_onNoteGroupDeleted);
    on<NoteGroupsOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final NoteGroupRepository _noteGroupRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: NoteGroupsOverviewStatus.loading));

    await emit.forEach<List<NoteGroup>>(
      _noteGroupRepository.getNoteGroupsByUserId(event.userId),
      onData: (noteGroups) => state.copyWith(
        status: NoteGroupsOverviewStatus.success,
        noteGroups: noteGroups,
      ),
      onError: (_, __) => state.copyWith(
        status: NoteGroupsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onNoteGroupDeleted(event, emit) async {
    emit(state.copyWith(lastDeletedNoteGroup: event.noteGroup));
    await _noteGroupRepository.deleteNoteGroup(event.noteGroup.id);
  }

  Future<void> _onUndoDeletionRequested(event, emit) async {
    assert(
      state.lastDeletedNoteGroup != null,
      'Last deleted noteGroup can not be null.',
    );

    final noteGroup = state.lastDeletedNoteGroup!;
    emit(state.copyWith(lastDeletedNoteGroup: null));
    await _noteGroupRepository.createNoteGroup(noteGroup);
  }
}
