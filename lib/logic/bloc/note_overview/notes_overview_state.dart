part of 'notes_overview_bloc.dart';

enum NotesOverviewStatus { initial, loading, success, failure }

class NotesOverviewState extends Equatable {
  const NotesOverviewState({
    this.status = NotesOverviewStatus.initial,
    this.notes = const [],
    this.lastDeletedNote,
  });

  final NotesOverviewStatus status;
  final List<Note> notes;
  final Note? lastDeletedNote;

  NotesOverviewState copyWith({
    NotesOverviewStatus? status,
    List<Note>? notes,
    Note? lastDeletedNote,
  }) {
    return NotesOverviewState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      lastDeletedNote: lastDeletedNote ?? this.lastDeletedNote,
    );
  }

  @override
  List<Object?> get props => [status, notes, lastDeletedNote];
}
