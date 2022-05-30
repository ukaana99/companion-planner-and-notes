part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskSubscriptionRequested extends TaskEvent {
  const TaskSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class TaskTaskDeleted extends TaskEvent {
  const TaskTaskDeleted(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskUndoDeletionRequested extends TaskEvent {
  const TaskUndoDeletionRequested();
}
