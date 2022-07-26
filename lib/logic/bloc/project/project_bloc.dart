import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/activity.dart';
import '../../../data/models/note_group.dart';
import '../../../data/models/project.dart';
import '../../../data/models/task_group.dart';
import '../../../data/repositories/activity_repo.dart';
import '../../../data/repositories/note_group_repo.dart';
import '../../../data/repositories/project_repo.dart';
import '../../../data/repositories/task_group_repo.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required ProjectRepository projectRepository,
    required ActivityRepository activityRepository,
    required TaskGroupRepository taskGroupRepository,
    required NoteGroupRepository noteGroupRepository,
  })  : _projectRepository = projectRepository,
        _activityRepository = activityRepository,
        _taskGroupRepository = taskGroupRepository,
        _noteGroupRepository = noteGroupRepository,
        super(const ProjectState()) {
    on<ProjectSubscriptionRequested>(_onSubscriptionRequested);
    on<ProjectActivitiesSubscriptionRequested>(_onActivitiesSubscriptionRequested);
    on<ProjectTaskGroupsSubscriptionRequested>(_onTaskGroupsSubscriptionRequested);
    on<ProjectNoteGroupsSubscriptionRequested>(_onNoteGroupsSubscriptionRequested);
  }

  final ProjectRepository _projectRepository;
  final ActivityRepository _activityRepository;
  final TaskGroupRepository _taskGroupRepository;
  final NoteGroupRepository _noteGroupRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ProjectStatus.loading));

    await emit.forEach<Project>(
      _projectRepository.getProjectStream(event.id),
      onData: (project) => state.copyWith(
        status: ProjectStatus.success,
        project: project,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectStatus.failure,
      ),
    );
  }

  Future<void> _onActivitiesSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ProjectStatus.loading));

    await emit.forEach<List<Activity>>(
      _activityRepository.getActivitiesByProjectId(event.id),
      onData: (activities) => state.copyWith(
        status: ProjectStatus.success,
        activities: activities,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectStatus.failure,
      ),
    );
  }

  Future<void> _onTaskGroupsSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ProjectStatus.loading));

    await emit.forEach<List<TaskGroup>>(
      _taskGroupRepository.getTaskGroupsByProjectId(event.id),
      onData: (taskGroups) => state.copyWith(
        status: ProjectStatus.success,
        taskGroups: taskGroups,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectStatus.failure,
      ),
    );
  }

  Future<void> _onNoteGroupsSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ProjectStatus.loading));

    await emit.forEach<List<NoteGroup>>(
      _noteGroupRepository.getNoteGroupsByProjectId(event.id),
      onData: (noteGroups) => state.copyWith(
        status: ProjectStatus.success,
        noteGroups: noteGroups,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectStatus.failure,
      ),
    );
  }
}
