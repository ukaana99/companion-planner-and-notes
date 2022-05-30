import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'task.g.dart';

@immutable
@JsonSerializable()
class Task extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final List<String>? tags;
  final DateTime? deadline;
  final String? colorHex;
  final String? groupId;
  final String? userId;

  const Task({
    this.id,
    this.title,
    this.description = '',
    this.isCompleted = false,
    this.tags = const [],
    this.deadline,
    this.colorHex,
    this.groupId,
    this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.fromRawJson(String str) => Task.fromJson(jsonDecode(str));

  factory Task.fromFire(snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return Task.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  String toRawJson() => jsonEncode(toJson());

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? deadline,
    String? colorHex,
    List<String>? tags,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        tags: tags ?? this.tags,
        deadline: deadline ?? this.deadline,
        colorHex: colorHex ?? this.colorHex,
        groupId: groupId,
        userId: userId,
      );

  @override
  List<Object?> get props =>
      [id, title, description, isCompleted, deadline, colorHex, tags];
}