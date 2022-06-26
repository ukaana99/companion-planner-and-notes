part of 'task_groups_overview_bloc.dart';

enum TaskGroupsOverviewStatus { initial, loading, success, failure }

class TaskGroupsOverviewState extends Equatable {
  const TaskGroupsOverviewState({
    this.status = TaskGroupsOverviewStatus.initial,
    this.taskGroups = const [],
    this.lastDeletedTaskGroup,
  });

  final TaskGroupsOverviewStatus status;
  final List<TaskGroup> taskGroups; 
  final TaskGroup? lastDeletedTaskGroup;

  TaskGroupsOverviewState copyWith({
    TaskGroupsOverviewStatus? status,
    List<TaskGroup>? taskGroups,
    TaskGroup? lastDeletedTaskGroup,
  }) {
    return TaskGroupsOverviewState(
      status: status ?? this.status,
      taskGroups: taskGroups ?? this.taskGroups,
      lastDeletedTaskGroup: lastDeletedTaskGroup ?? this.lastDeletedTaskGroup,
    );
  }

  @override
  List<Object?> get props => [status, taskGroups, lastDeletedTaskGroup];
}
