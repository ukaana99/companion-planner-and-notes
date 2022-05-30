part of 'task_cubit.dart';

class TaskState extends Equatable {
  final Task? task;
  final String title;
  final String description;
  final String colorHex;
  final DateTime deadline;
  final String groupId;

  const TaskState({
    this.task,
    this.title = '',
    this.description = '',
    this.colorHex = '',
    required this.deadline,
    this.groupId = '',
  });

  @override
  List<Object> get props => [title, description, colorHex, deadline, groupId];

  TaskState copyWith({
    Task? task,
    String? title,
    String? description,
    String? colorHex,
    DateTime? deadline,
    String? groupId,
  }) {
    return TaskState(
      task: task ?? this.task,
      title: title ?? this.title,
      description: description ?? this.description,
      colorHex: colorHex ?? this.colorHex,
      deadline: deadline ?? this.deadline,
      groupId: groupId ?? this.groupId,
    );
  }
}
