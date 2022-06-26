part of 'task_groups_overview_bloc.dart';

abstract class TaskGroupsOverviewEvent extends Equatable {
  const TaskGroupsOverviewEvent();

  @override
  List<Object> get props => [];
}

class TaskGroupsOverviewSubscriptionRequested extends TaskGroupsOverviewEvent {
  const TaskGroupsOverviewSubscriptionRequested(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}

class TaskGroupsOverviewTaskGroupDeleted extends TaskGroupsOverviewEvent {
  const TaskGroupsOverviewTaskGroupDeleted(this.taskGroup);

  final TaskGroup taskGroup;

  @override
  List<Object> get props => [taskGroup];
}

class TaskGroupsOverviewUndoDeletionRequested extends TaskGroupsOverviewEvent {
  const TaskGroupsOverviewUndoDeletionRequested();
}
