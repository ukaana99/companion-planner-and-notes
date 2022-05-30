// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteGroup _$NoteGroupFromJson(Map<String, dynamic> json) => NoteGroup(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      colorHex: json['colorHex'] as String?,
      userId: json['userId'] as String?,
      projectId: json['projectId'] as String?,
    );

Map<String, dynamic> _$NoteGroupToJson(NoteGroup instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'tags': instance.tags,
      'colorHex': instance.colorHex,
      'userId': instance.userId,
      'projectId': instance.projectId,
    };
