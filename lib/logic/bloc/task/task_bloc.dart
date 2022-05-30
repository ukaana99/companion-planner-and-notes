import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/task.dart';
import '../../../data/repositories/task_repo.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(const TaskState()) {
    on<TaskSubscriptionRequested>(_onSubscriptionRequested);
  }

  final TaskRepository _taskRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: TaskStatus.loading));

    await emit.forEach<Task>(
      _taskRepository.getTaskStream(event.id),
      onData: (task) => state.copyWith(
        status: TaskStatus.success,
        task: task,
      ),
      onError: (_, __) => state.copyWith(
        status: TaskStatus.failure,
      ),
    );
  }
}
