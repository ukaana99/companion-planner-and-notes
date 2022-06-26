part of 'note_cubit.dart';

class NoteState extends Equatable {
  final Note? note;
  final String title;
  final String content;
  final String groupId;
  final XFile? image;
  final String scannedText;

  const NoteState({
    this.note,
    this.title = '',
    this.content = '',
    this.groupId = '',
    this.scannedText = '',
    this.image,
  });

  @override
  List<Object> get props => image != null
      ? [title, content, groupId, scannedText, image!]
      : [title, content, groupId, scannedText];

  NoteState copyWith({
    Note? note,
    String? title,
    String? content,
    String? groupId,
    String? scannedText,
    XFile? image,
  }) {
    return NoteState(
      note: note ?? this.note,
      title: title ?? this.title,
      content: content ?? this.content,
      groupId: groupId ?? this.groupId,
      scannedText: scannedText ?? this.scannedText,
      image: image ?? this.image,
    );
  }
}
