// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      deadline:
          const TimestampConverter().fromJson(json['deadline'] as Timestamp?),
      colorHex: json['colorHex'] as String? ?? '0xffffffff',
      groupId: json['groupId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'tags': instance.tags,
      'colorHex': instance.colorHex,
      'groupId': instance.groupId,
      'userId': instance.userId,
      'deadline': const TimestampConverter().toJson(instance.deadline),
    };
