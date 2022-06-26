part of 'tasks_overview_bloc.dart';

abstract class TasksOverviewEvent extends Equatable {
  const TasksOverviewEvent();

  @override
  List<Object> get props => [];
}

class TasksOverviewSubscriptionRequested extends TasksOverviewEvent {
  const TasksOverviewSubscriptionRequested(this.groupId);

  final String groupId;

  @override
  List<Object> get props => [groupId];
}

class TasksOverviewTaskCompletionToggled extends TasksOverviewEvent {
  const TasksOverviewTaskCompletionToggled({
    required this.task,
    required this.isCompleted,
  });

  final Task task;
  final bool isCompleted;

  @override
  List<Object> get props => [task, isCompleted];
}

class TasksOverviewTaskDeleted extends TasksOverviewEvent {
  const TasksOverviewTaskDeleted(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TasksOverviewAllTasksDeleted extends TasksOverviewEvent {
  const TasksOverviewAllTasksDeleted(this.groupId);

  final String groupId;

  @override
  List<Object> get props => [groupId];
}

class TasksOverviewUndoDeletionRequested extends TasksOverviewEvent {
  const TasksOverviewUndoDeletionRequested();
}
