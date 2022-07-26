// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      coordinator: json['coordinator'] as String? ?? '',
      colorHex: json['colorHex'] as String? ?? '0xffffffff',
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      // 'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'coordinator': instance.coordinator,
      'colorHex': instance.colorHex,
      'userId': instance.userId,
    };
