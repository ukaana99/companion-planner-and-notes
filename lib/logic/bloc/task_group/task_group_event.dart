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

class TaskGroupTaskGroupDeleted extends TaskGroupEvent {
  const TaskGroupTaskGroupDeleted(this.taskGroup);

  final TaskGroup taskGroup;

  @override
  List<Object> get props => [taskGroup];
}

class TaskGroupUndoDeletionRequested extends TaskGroupEvent {
  const TaskGroupUndoDeletionRequested();
}
