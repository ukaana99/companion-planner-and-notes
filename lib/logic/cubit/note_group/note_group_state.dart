part of 'note_group_cubit.dart';

class NoteGroupState extends Equatable {
  final NoteGroup? noteGroup;
  final String title;
  final String description;
  final String colorHex;
  final String projectId;


  const NoteGroupState({
    this.noteGroup,
    this.title = '',
    this.description = '',
    this.colorHex = '',
    this.projectId = '',
  });

  @override
  List<Object> get props => [title, description, colorHex, projectId];

  NoteGroupState copyWith({
    NoteGroup? noteGroup,
    String? title,
    String? description,
    String? colorHex,
    String? projectId,
  }) {
    return NoteGroupState(
      noteGroup: noteGroup ?? this.noteGroup,
      title: title ?? this.title,
      description: description ?? this.description,
      colorHex: colorHex ?? this.colorHex,
      projectId: projectId ?? this.projectId,
    );
  }
}
