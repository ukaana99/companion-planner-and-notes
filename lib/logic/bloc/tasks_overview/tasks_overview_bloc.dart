import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/task.dart';
import '../../../data/repositories/task_repo.dart';

part 'tasks_overview_event.dart';
part 'tasks_overview_state.dart';

class TasksOverviewBloc extends Bloc<TasksOverviewEvent, TasksOverviewState> {
  TasksOverviewBloc({
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(const TasksOverviewState()) {
    on<TasksOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TasksOverviewTaskCompletionToggled>(_onTaskCompletionToggled);
    on<TasksOverviewTaskDeleted>(_onTaskDeleted);
    on<TasksOverviewAllTasksDeleted>(_onAllTasksDeleted);
    on<TasksOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final TaskRepository _taskRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: TasksOverviewStatus.loading));

    await emit.forEach<List<Task>>(
      _taskRepository.getTasksByGroupId(event.groupId),
      onData: (tasks) => state.copyWith(
        status: TasksOverviewStatus.success,
        tasks: tasks,
      ),
      onError: (_, __) => state.copyWith(
        status: TasksOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onTaskCompletionToggled(event, emit) async {
    final task = event.task.copyWith(isCompleted: event.isCompleted);
    await _taskRepository.updateTask(task.id, task);
  }

  Future<void> _onTaskDeleted(event, emit) async {
    emit(state.copyWith(lastDeletedTask: event.task));
    await _taskRepository.deleteTask(event.task.id);
  }

  Future<void> _onAllTasksDeleted(event, emit) async {
    await _taskRepository.deleteTasksByGroupId(event.groupId);
  }

  Future<void> _onUndoDeletionRequested(event, emit) async {
    assert(
      state.lastDeletedTask != null,
      'Last deleted task can not be null.',
    );

    final task = state.lastDeletedTask!;
    emit(state.copyWith(lastDeletedTask: null));
    await _taskRepository.createTask(task);
  }
}
