import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/note_group.dart';
import '../../../data/repositories/note_group_repo.dart';

part 'note_group_event.dart';
part 'note_group_state.dart';

class NoteGroupBloc extends Bloc<NoteGroupEvent, NoteGroupState> {
  NoteGroupBloc({
    required NoteGroupRepository noteGroupRepository,
  })  : _noteGroupRepository = noteGroupRepository,
        super(const NoteGroupState()) {
    on<NoteGroupSubscriptionRequested>(_onSubscriptionRequested);
  }

  final NoteGroupRepository _noteGroupRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: NoteGroupStatus.loading));

    await emit.forEach<NoteGroup>(
      _noteGroupRepository.getNoteGroupStream(event.id),
      onData: (noteGroup) => state.copyWith(
        status: NoteGroupStatus.success,
        noteGroup: noteGroup,
      ),
      onError: (_, __) => state.copyWith(
        status: NoteGroupStatus.failure,
      ),
    );
  }
}
