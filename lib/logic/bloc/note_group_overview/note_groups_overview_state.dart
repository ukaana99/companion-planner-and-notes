part of 'note_groups_overview_bloc.dart';

enum NoteGroupsOverviewStatus { initial, loading, success, failure }

class NoteGroupsOverviewState extends Equatable {
  const NoteGroupsOverviewState({
    this.status = NoteGroupsOverviewStatus.initial,
    this.noteGroups = const [],
    this.lastDeletedNoteGroup,
  });

  final NoteGroupsOverviewStatus status;
  final List<NoteGroup> noteGroups; 
  final NoteGroup? lastDeletedNoteGroup;

  NoteGroupsOverviewState copyWith({
    NoteGroupsOverviewStatus? status,
    List<NoteGroup>? noteGroups,
    NoteGroup? lastDeletedNoteGroup,
  }) {
    return NoteGroupsOverviewState(
      status: status ?? this.status,
      noteGroups: noteGroups ?? this.noteGroups,
      lastDeletedNoteGroup: lastDeletedNoteGroup ?? this.lastDeletedNoteGroup,
    );
  }

  @override
  List<Object?> get props => [status, noteGroups, lastDeletedNoteGroup];
}
