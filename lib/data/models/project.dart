import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'project.g.dart';

@immutable
@JsonSerializable()
class Project extends Equatable {
  final String id;
  final String? name;
  final String? description;
  final String? coordinator;
  final String? userId;

  const Project({
    required this.id,
    this.name,
    this.description,
    this.coordinator,
    this.userId,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  factory Project.fromRawJson(String str) => Project.fromJson(jsonDecode(str));

  factory Project.fromFire(snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return Project.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  String toRawJson() => jsonEncode(toJson());

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? coordinator,
  }) =>
      Project(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        coordinator: coordinator ?? this.coordinator,
        userId: userId,
      );

  @override
  List<Object?> get props => [id];
}
