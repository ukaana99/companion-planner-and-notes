part of 'note_groups_overview_bloc.dart';

abstract class NoteGroupsOverviewEvent extends Equatable {
  const NoteGroupsOverviewEvent();

  @override
  List<Object> get props => [];
}

class NoteGroupsOverviewSubscriptionRequested extends NoteGroupsOverviewEvent {
  const NoteGroupsOverviewSubscriptionRequested(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}

class NoteGroupsOverviewNoteGroupDeleted extends NoteGroupsOverviewEvent {
  const NoteGroupsOverviewNoteGroupDeleted(this.noteGroup);

  final NoteGroup noteGroup;

  @override
  List<Object> get props => [noteGroup];
}

class NoteGroupsOverviewUndoDeletionRequested extends NoteGroupsOverviewEvent {
  const NoteGroupsOverviewUndoDeletionRequested();
}
