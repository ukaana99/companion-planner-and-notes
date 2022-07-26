import 'package:bloc/bloc.dart';
import 'package:companion/data/models/task_group.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/task_group_repo.dart';

part 'task_group_state.dart';

class TaskGroupCubit extends Cubit<TaskGroupState> {
  TaskGroupCubit({
    this.taskGroup,
    required TaskGroupRepository taskGroupRepository,
  })  : _taskGroupRepository = taskGroupRepository,
        super(TaskGroupState(
          taskGroup: taskGroup ?? const TaskGroup(),
          title: taskGroup?.title ?? '',
          description: taskGroup?.description ?? '',
          colorHex: taskGroup?.colorHex ?? '0xffffffff',
          projectId: taskGroup?.projectId ?? '',
        ));

  final TaskGroupRepository _taskGroupRepository;
  final TaskGroup? taskGroup;

  void titleChanged(String value) => emit(state.copyWith(title: value));

  void descriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void colorChanged(String value) => emit(state.copyWith(colorHex: value));

  void projectIdChanged(String? value) =>
      emit(state.copyWith(projectId: value));

  Future<void> submitForm(String userId) async {
    final taskGroup = TaskGroup(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
      projectId: state.projectId,
      userId: userId,
    );
    try {
      await _taskGroupRepository.createTaskGroup(taskGroup);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }

  Future<void> updateForm() async {
    final taskGroup = state.taskGroup?.copyWith(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
    );
    try {
      await _taskGroupRepository.updateTaskGroup(
          state.taskGroup!.id!, taskGroup!);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }
}
