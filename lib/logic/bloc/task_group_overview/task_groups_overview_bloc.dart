import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/task_group.dart';
import '../../../data/repositories/task_group_repo.dart';

part 'task_groups_overview_event.dart';
part 'task_groups_overview_state.dart';

class TaskGroupsOverviewBloc
    extends Bloc<TaskGroupsOverviewEvent, TaskGroupsOverviewState> {
  TaskGroupsOverviewBloc({
    required TaskGroupRepository taskGroupRepository,
  })  : _taskGroupRepository = taskGroupRepository,
        super(const TaskGroupsOverviewState()) {
    on<TaskGroupsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TaskGroupsOverviewTaskGroupDeleted>(_onTaskGroupDeleted);
    on<TaskGroupsOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final TaskGroupRepository _taskGroupRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: TaskGroupsOverviewStatus.loading));

    await emit.forEach<List<TaskGroup>>(
      _taskGroupRepository.getTaskGroupsByUserId(event.userId),
      onData: (taskGroups) => state.copyWith(
        status: TaskGroupsOverviewStatus.success,
        taskGroups: taskGroups,
      ),
      onError: (_, __) => state.copyWith(
        status: TaskGroupsOverviewStatus.failure,
      ),
    );
    // await emit.forEach<List<TaskGroup>>(
    //   _taskGroupRepository.getPendingTaskGroups(event.userId),
    //   onData: (taskGroups) => state.copyWith(
    //     status: TaskGroupsOverviewStatus.success,
    //     pendingTaskGroups: taskGroups,
    //   ),
    //   onError: (_, __) => state.copyWith(
    //     status: TaskGroupsOverviewStatus.failure,
    //   ),
    // );

    // await emit.forEach<List<TaskGroup>>(
    //   _taskGroupRepository.getDoneTaskGroups(event.userId),
    //   onData: (taskGroups) => state.copyWith(
    //     status: TaskGroupsOverviewStatus.success,
    //     doneTaskGroups: taskGroups,
    //   ),
    //   onError: (_, __) => state.copyWith(
    //     status: TaskGroupsOverviewStatus.failure,
    //   ),
    // );
  }

  Future<void> _onTaskGroupDeleted(event, emit) async {
    emit(state.copyWith(lastDeletedTaskGroup: event.taskGroup));
    await _taskGroupRepository.deleteTaskGroup(event.taskGroup.id);
  }

  Future<void> _onUndoDeletionRequested(event, emit) async {
    assert(
      state.lastDeletedTaskGroup != null,
      'Last deleted taskGroup can not be null.',
    );

    final taskGroup = state.lastDeletedTaskGroup!;
    emit(state.copyWith(lastDeletedTaskGroup: null));
    await _taskGroupRepository.createTaskGroup(taskGroup);
  }
}
