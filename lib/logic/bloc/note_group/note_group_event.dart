part of 'note_group_bloc.dart';

abstract class NoteGroupEvent extends Equatable {
  const NoteGroupEvent();

  @override
  List<Object> get props => [];
}

class NoteGroupSubscriptionRequested extends NoteGroupEvent {
  const NoteGroupSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class NoteGroupNoteGroupDeleted extends NoteGroupEvent {
  const NoteGroupNoteGroupDeleted(this.noteGroup);

  final NoteGroup noteGroup;

  @override
  List<Object> get props => [noteGroup];
}

class NoteGroupUndoDeletionRequested extends NoteGroupEvent {
  const NoteGroupUndoDeletionRequested();
}
