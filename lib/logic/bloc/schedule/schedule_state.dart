part of 'schedule_bloc.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.activities = const [],
    this.projects = const [],
  });

  final ScheduleStatus status;
  final List<Activity> activities;
  final List<Project> projects;

  ScheduleState copyWith({
    ScheduleStatus? status,
    List<Activity>? activities,
    List<Project>? projects,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object?> get props => [status, activities, projects];
}
