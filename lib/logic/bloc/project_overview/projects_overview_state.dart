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
    ProjectsOverviewStatus Function()? status,
    List<Project> Function()? projects,
    Project? Function()? lastDeletedProject,
  }) {
    return ProjectsOverviewState(
      status: status != null ? status() : this.status,
      projects: projects != null ? projects() : this.projects,
      lastDeletedProject:
          lastDeletedProject != null ? lastDeletedProject() : this.lastDeletedProject,
    );
  }

  @override
  List<Object?> get props => [
        status,
        projects,
        lastDeletedProject,
      ];
}
