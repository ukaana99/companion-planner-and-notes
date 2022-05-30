part of 'task_group_bloc.dart';

enum TaskGroupStatus { initial, loading, success, failure }

class TaskGroupState extends Equatable {
  const TaskGroupState({
    this.status = TaskGroupStatus.initial,
    this.taskGroup = const TaskGroup(),
  });

  final TaskGroupStatus status;
  final TaskGroup taskGroup;

  TaskGroupState copyWith({
    TaskGroupStatus? status,
    TaskGroup? taskGroup,
  }) {
    return TaskGroupState(
      status:  status?? this.status,
      taskGroup:  taskGroup?? this.taskGroup,
    );
  }

  @override
  List<Object?> get props => [status, taskGroup];
}
