import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'timestamp_converter.dart';

part 'activity.g.dart';

@immutable
@JsonSerializable()
class Activity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final bool? isRepeated;
  final List<bool>? daysRepeated;
  final String? colorHex;
  final String? projectId;
  final String? userId;
  @TimestampConverter()
  final DateTime? dateTime;

  const Activity({
    this.id,
    this.title = '',
    this.description = '',
    this.isRepeated = false,
    this.daysRepeated = const [false, false, false, false, false, false, false],
    this.dateTime,
    this.colorHex = '0xffffffff',
    this.projectId,
    this.userId,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  factory Activity.fromRawJson(String str) =>
      Activity.fromJson(jsonDecode(str));

  factory Activity.fromFire(snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return Activity.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  String toRawJson() => jsonEncode(toJson());

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isRepeated,
    List<bool>? daysRepeated,
    DateTime? dateTime,
    String? colorHex,
  }) =>
      Activity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isRepeated: isRepeated ?? this.isRepeated,
        daysRepeated: daysRepeated ?? this.daysRepeated,
        dateTime: dateTime ?? this.dateTime,
        colorHex: colorHex ?? this.colorHex,
        projectId: projectId,
        userId: userId,
      );

  @override
  List<Object?> get props =>
      [id, title, description, isRepeated, daysRepeated, dateTime, colorHex];
}
