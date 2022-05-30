part of 'project_bloc.dart';

enum ProjectStatus { initial, loading, success, failure }

class ProjectState extends Equatable {
  const ProjectState({
    this.status = ProjectStatus.initial,
    this.project = const Project(),
  });

  final ProjectStatus status;
  final Project project;

  ProjectState copyWith({
    ProjectStatus? status,
    Project? project,
  }) {
    return ProjectState(
      status:  status?? this.status,
      project:  project?? this.project,
    );
  }

  @override
  List<Object?> get props => [status, project];
}
