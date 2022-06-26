part of 'projects_overview_bloc.dart';

enum ProjectsOverviewStatus { initial, loading, success, failure }

class ProjectsOverviewState extends Equatable {
  const ProjectsOverviewState({
    this.status = ProjectsOverviewStatus.initial,
    this.projects = const [],
    this.lastDeletedProject,
  });

  final ProjectsOverviewStatus status;
  final List<Project> projects;
  final Project? lastDeletedProject;

  ProjectsOverviewState copyWith({
    ProjectsOverviewStatus? status,
    List<Project>? projects,
    Project? lastDeletedProject,
  }) {
    return ProjectsOverviewState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      lastDeletedProject: lastDeletedProject ?? this.lastDeletedProject,
    );
  }

  @override
  List<Object?> get props => [status, projects, lastDeletedProject];
}
