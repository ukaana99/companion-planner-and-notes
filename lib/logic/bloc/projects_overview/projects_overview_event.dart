part of 'projects_overview_bloc.dart';

abstract class ProjectsOverviewEvent extends Equatable {
  const ProjectsOverviewEvent();

  @override
  List<Object> get props => [];
}

class ProjectsOverviewSubscriptionRequested extends ProjectsOverviewEvent {
  const ProjectsOverviewSubscriptionRequested(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}

class ProjectsOverviewProjectDeleted extends ProjectsOverviewEvent {
  const ProjectsOverviewProjectDeleted(this.project);

  final Project project;

  @override
  List<Object> get props => [project];
}

class ProjectsOverviewUndoDeletionRequested extends ProjectsOverviewEvent {
  const ProjectsOverviewUndoDeletionRequested();
}
