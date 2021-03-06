part of 'task_group_bloc.dart';

abstract class TaskGroupEvent extends Equatable {
  const TaskGroupEvent();

  @override
  List<Object> get props => [];
}

class TaskGroupSubscriptionRequested extends TaskGroupEvent {
  const TaskGroupSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class TaskGroupTaskGroupCompletionUpdated extends TaskGroupEvent {
  const TaskGroupTaskGroupCompletionUpdated({
    required this.taskGroup,
    required this.total,
    required this.completed,
  });

  final TaskGroup taskGroup;
  final int total;
  final int completed;

  @override
  List<Object> get props => [taskGroup, total, completed];
}

class TaskGroupTaskGroupDeleted extends TaskGroupEvent {
  const TaskGroupTaskGroupDeleted(this.taskGroup);

  final TaskGroup taskGroup;

  @override
  List<Object> get props => [taskGroup];
}

class TaskGroupUndoDeletionRequested extends TaskGroupEvent {
  const TaskGroupUndoDeletionRequested();
}
