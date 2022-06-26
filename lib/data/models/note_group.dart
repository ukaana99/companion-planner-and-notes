import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'note_group.g.dart';

@immutable
@JsonSerializable()
class NoteGroup extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? tags;
  final String? colorHex;
  final String? userId;
  final String? projectId;

  const NoteGroup({
    this.id,
    this.title = '',
    this.description = '',
    this.tags = const [],
    this.colorHex = '0xffffffff',
    this.userId,
    this.projectId,
  });

  factory NoteGroup.fromJson(Map<String, dynamic> json) =>
      _$NoteGroupFromJson(json);

  factory NoteGroup.fromRawJson(String str) =>
      NoteGroup.fromJson(jsonDecode(str));

  factory NoteGroup.fromFire(snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return NoteGroup.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$NoteGroupToJson(this);

  String toRawJson() => jsonEncode(toJson());

  NoteGroup copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? tags,
    int? completion,
    String? colorHex,
  }) =>
      NoteGroup(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        colorHex: colorHex ?? this.colorHex,
        userId: userId,
        projectId: projectId,
      );

  @override
  List<Object?> get props => [id, title, description, tags, colorHex];
}
