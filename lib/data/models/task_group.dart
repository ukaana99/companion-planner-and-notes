import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'task_group.g.dart';

@immutable
@JsonSerializable()
class TaskGroup extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? tags;
  final int? completion;
  final String? colorHex;
  final String? userId;
  final String? projectId;

  const TaskGroup({
    this.id,
    this.title,
    this.description = '',
    this.tags = const [],
    this.completion = 0,
    this.colorHex = '0xffffffff',
    this.userId,
    this.projectId,
  });

  factory TaskGroup.fromJson(Map<String, dynamic> json) =>
      _$TaskGroupFromJson(json);

  factory TaskGroup.fromRawJson(String str) =>
      TaskGroup.fromJson(jsonDecode(str));

  factory TaskGroup.fromFire(snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return TaskGroup.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskGroupToJson(this);

  String toRawJson() => jsonEncode(toJson());

  TaskGroup copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? tags,
    int? completion,
    String? colorHex,
  }) =>
      TaskGroup(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        completion: completion ?? this.completion,
        colorHex: colorHex ?? this.colorHex,
        userId: userId,
        projectId: projectId,
      );

  @override
  List<Object?> get props => [id, title, description, tags, completion, colorHex];
}
