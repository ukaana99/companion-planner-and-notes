// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskGroup _$TaskGroupFromJson(Map<String, dynamic> json) => TaskGroup(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      completion: json['completion'] as int?,
      colorHex: json['colorHex'] as String?,
      userId: json['userId'] as String?,
      projectId: json['projectId'] as String?,
    );

Map<String, dynamic> _$TaskGroupToJson(TaskGroup instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'tags': instance.tags,
      'completion': instance.completion,
      'colorHex': instance.colorHex,
      'userId': instance.userId,
      'projectId': instance.projectId,
    };
