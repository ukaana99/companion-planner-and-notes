part of 'activity_cubit.dart';

class ActivityState extends Equatable {
  final Activity? activity;
  final String title;
  final String description;
  final String colorHex;
  final bool isRepeated;
  final List<bool> daysRepeated;
  final DateTime dateTime;
  final String projectId;

  const ActivityState({
    this.activity,
    this.title = '',
    this.description = '',
    this.colorHex = '',
    this.isRepeated = false,
    this.daysRepeated = const [false, false, false, false, false, false, false],
    required this.dateTime,
    this.projectId = '',
  });

  @override
  List<Object> get props => [
        title,
        description,
        colorHex,
        isRepeated,
        daysRepeated,
        dateTime,
        projectId,
      ];

  ActivityState copyWith({
    Activity? activity,
    String? title,
    String? description,
    String? colorHex,
    bool? isRepeated,
    List<bool>? daysRepeated,
    DateTime? dateTime,
    String? projectId,
  }) {
    return ActivityState(
      activity: activity ?? this.activity,
      title: title ?? this.title,
      description: description ?? this.description,
      colorHex: colorHex ?? this.colorHex,
      dateTime: dateTime ?? this.dateTime,
      isRepeated: isRepeated ?? this.isRepeated,
      daysRepeated: daysRepeated ?? this.daysRepeated,
      projectId: projectId ?? this.projectId,
    );
  }
}
