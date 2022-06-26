part of 'notes_overview_bloc.dart';

abstract class NotesOverviewEvent extends Equatable {
  const NotesOverviewEvent();

  @override
  List<Object> get props => [];
}

class NotesOverviewSubscriptionRequested extends NotesOverviewEvent {
  const NotesOverviewSubscriptionRequested(this.groupId);

  final String groupId;

  @override
  List<Object> get props => [groupId];
}

class NotesOverviewNoteDeleted extends NotesOverviewEvent {
  const NotesOverviewNoteDeleted(this.note);

  final Note note;

  @override
  List<Object> get props => [note];
}

class NotesOverviewAllNotesDeleted extends NotesOverviewEvent {
  const NotesOverviewAllNotesDeleted(this.groupId);

  final String groupId;

  @override
  List<Object> get props => [groupId];
}

class NotesOverviewUndoDeletionRequested extends NotesOverviewEvent {
  const NotesOverviewUndoDeletionRequested();
}
