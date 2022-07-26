part of 'task_group_cubit.dart';

class TaskGroupState extends Equatable {
  final TaskGroup? taskGroup;
  final String title;
  final String description;
  final String colorHex;
  final String projectId;


  const TaskGroupState({
    this.taskGroup,
    this.title = '',
    this.description = '',
    this.colorHex = '',
    this.projectId = '',
  });

  @override
  List<Object> get props => [title, description, colorHex, projectId];

  TaskGroupState copyWith({
    TaskGroup? taskGroup,
    String? title,
    String? description,
    String? colorHex,
    String? projectId,
  }) {
    return TaskGroupState(
      taskGroup: taskGroup ?? this.taskGroup,
      title: title ?? this.title,
      description: description ?? this.description,
      colorHex: colorHex ?? this.colorHex,
      projectId: projectId ?? this.projectId,
    );
  }
}
