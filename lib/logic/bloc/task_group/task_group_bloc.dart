import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/task_group.dart';
import '../../../data/repositories/task_group_repo.dart';

part 'task_group_event.dart';
part 'task_group_state.dart';

class TaskGroupBloc extends Bloc<TaskGroupEvent, TaskGroupState> {
  TaskGroupBloc({
    required TaskGroupRepository taskGroupRepository,
  })  : _taskGroupRepository = taskGroupRepository,
        super(const TaskGroupState()) {
    on<TaskGroupSubscriptionRequested>(_onSubscriptionRequested);
  }

  final TaskGroupRepository _taskGroupRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: TaskGroupStatus.loading));

    await emit.forEach<TaskGroup>(
      _taskGroupRepository.getTaskGroupStream(event.id),
      onData: (taskGroup) => state.copyWith(
        status: TaskGroupStatus.success,
        taskGroup: taskGroup,
      ),
      onError: (_, __) => state.copyWith(
        status: TaskGroupStatus.failure,
      ),
    );
  }
}
