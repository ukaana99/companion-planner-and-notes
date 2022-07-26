// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isRepeated: json['isRepeated'] as bool? ?? false,
      daysRepeated: (json['daysRepeated'] as List<dynamic>?)
              ?.map((e) => e as bool)
              .toList() ??
          const [false, false, false, false, false, false, false],
      dateTime:
          const TimestampConverter().fromJson(json['dateTime'] as Timestamp?),
      colorHex: json['colorHex'] as String? ?? '0xffffffff',
      projectId: json['projectId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      // 'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isRepeated': instance.isRepeated,
      'daysRepeated': instance.daysRepeated,
      'colorHex': instance.colorHex,
      'projectId': instance.projectId,
      'userId': instance.userId,
      'dateTime': const TimestampConverter().toJson(instance.dateTime),
    };
