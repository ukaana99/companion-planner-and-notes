part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class ProjectSubscriptionRequested extends ProjectEvent {
  const ProjectSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class ProjectActivitiesSubscriptionRequested extends ProjectEvent {
  const ProjectActivitiesSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class ProjectTaskGroupsSubscriptionRequested extends ProjectEvent {
  const ProjectTaskGroupsSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class ProjectNoteGroupsSubscriptionRequested extends ProjectEvent {
  const ProjectNoteGroupsSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}


class ProjectProjectDeleted extends ProjectEvent {
  const ProjectProjectDeleted(this.project);

  final Project project;

  @override
  List<Object> get props => [project];
}

class ProjectUndoDeletionRequested extends ProjectEvent {
  const ProjectUndoDeletionRequested();
}
