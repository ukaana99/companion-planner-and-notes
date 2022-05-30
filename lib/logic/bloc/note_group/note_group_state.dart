part of 'note_group_bloc.dart';

enum NoteGroupStatus { initial, loading, success, failure }

class NoteGroupState extends Equatable {
  const NoteGroupState({
    this.status = NoteGroupStatus.initial,
    this.noteGroup = const NoteGroup(),
  });

  final NoteGroupStatus status;
  final NoteGroup noteGroup;

  NoteGroupState copyWith({
    NoteGroupStatus? status,
    NoteGroup? noteGroup,
  }) {
    return NoteGroupState(
      status:  status?? this.status,
      noteGroup:  noteGroup?? this.noteGroup,
    );
  }

  @override
  List<Object?> get props => [status, noteGroup];
}
