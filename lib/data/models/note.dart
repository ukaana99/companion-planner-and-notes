import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'note.g.dart';

@immutable
@JsonSerializable()
class Note extends Equatable {
  final String? id;
  final String? title;
  final String? content;
  final String? groupId;

  const Note({
    this.id,
    this.title,
    this.content,
    this.groupId,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  factory Note.fromRawJson(String str) => Note.fromJson(jsonDecode(str));

  factory Note.fromFire(snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return Note.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  String toRawJson() => jsonEncode(toJson());

  Note copyWith({
    String? id,
    String? title,
    String? content,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        groupId: groupId,
      );

  @override
  List<Object?> get props => [id, title, content];
}
