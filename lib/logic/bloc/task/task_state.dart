part of 'task_bloc.dart';

enum TaskStatus { initial, loading, success, failure }

class TaskState extends Equatable {
  const TaskState({
    this.status = TaskStatus.initial,
    this.task = const Task(),
  });

  final TaskStatus status;
  final Task task;

  TaskState copyWith({
    TaskStatus? status,
    Task? task,
  }) {
    return TaskState(
      status:  status?? this.status,
      task:  task?? this.task,
    );
  }

  @override
  List<Object?> get props => [status, task];
}
