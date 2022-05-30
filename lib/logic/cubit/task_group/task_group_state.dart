part of 'task_group_cubit.dart';

class TaskGroupState extends Equatable {
  final TaskGroup? taskGroup;
  final String title;
  final String description;
  final String colorHex;

  const TaskGroupState({
    this.taskGroup,
    this.title = '',
    this.description = '',
    this.colorHex = '',
  });

  @override
  List<Object> get props => [title, description, colorHex];

  TaskGroupState copyWith({
    TaskGroup? taskGroup,
    String? title,
    String? description,
    String? colorHex,
  }) {
    return TaskGroupState(
      taskGroup: taskGroup ?? this.taskGroup,
      title: title ?? this.title,
      description: description ?? this.description,
      colorHex: colorHex ?? this.colorHex,
    );
  }
}
