import 'package:bloc/bloc.dart';
import 'package:companion/data/models/task.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/task_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({
    this.task,
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(TaskState(
          task: task ?? const Task(),
          title: task?.title ?? '',
          description: task?.description ?? '',
          colorHex: task?.colorHex ?? '0xffffffff',
          deadline: task?.deadline ?? DateTime.now(),
          groupId: task?.groupId ?? '',
        ));

  final TaskRepository _taskRepository;
  final Task? task;

  void titleChanged(String value) => emit(state.copyWith(title: value));

  void descriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void colorChanged(String value) => emit(state.copyWith(colorHex: value));

  void deadlineChanged(DateTime value) => emit(state.copyWith(deadline: value));

  void groupIdChanged(String? value) => emit(state.copyWith(groupId: value));

  Future<void> submitForm(String userId, {String? groupId}) async {
    final task = Task(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
      deadline: state.deadline,
      groupId: groupId ?? state.groupId,
      userId: userId,
    );
    try {
      await _taskRepository.createTask(task);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }

  Future<void> updateForm() async {
    final task = state.task?.copyWith(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
      deadline: state.deadline,
    );
    try {
      await _taskRepository.updateTask(state.task!.id!, task!);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }
}
