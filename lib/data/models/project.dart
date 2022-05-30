import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'project.g.dart';

@immutable
@JsonSerializable()
class Project extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? coordinator;
  final String? colorHex;
  final String? userId;

  const Project({
    this.id,
    this.title,
    this.description = '',
    this.coordinator = '',
    this.colorHex = '0xffffffff',
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
    String? title,
    String? description,
    String? coordinator,
    String? colorHex,
    String? userId,
  }) =>
      Project(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        coordinator: coordinator ?? this.coordinator,
        colorHex: colorHex ?? this.colorHex,
        userId: userId ?? this.userId,
      );

  @override
  List<Object?> get props => [id, title, description, coordinator, colorHex];
}
