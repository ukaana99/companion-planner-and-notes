part of 'project_bloc.dart';

enum ProjectStatus { initial, loading, success, failure }

class ProjectState extends Equatable {
  const ProjectState({
    this.status = ProjectStatus.initial,
    this.project = const Project(),
    this.activities = const [],
    this.taskGroups = const [],
    this.noteGroups = const [],
  });

  final ProjectStatus status;
  final Project project;
  final List<Activity> activities;
  final List<TaskGroup> taskGroups;
  final List<NoteGroup> noteGroups;

  ProjectState copyWith({
    ProjectStatus? status,
    Project? project,
    List<Activity>? activities,
    List<TaskGroup>? taskGroups,
    List<NoteGroup>? noteGroups,
  }) {
    return ProjectState(
      status: status ?? this.status,
      project: project ?? this.project,
      activities: activities ?? this.activities,
      taskGroups: taskGroups ?? this.taskGroups,
      noteGroups: noteGroups ?? this.noteGroups,
    );
  }

  @override
  List<Object?> get props =>
      [status, project, activities, taskGroups, noteGroups];
}
