import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/activity.dart';
import '../../../data/models/project.dart';
import '../../../data/repositories/activity_repo.dart';
import '../../../data/repositories/project_repo.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({
    required ActivityRepository activityRepository,
    required ProjectRepository projectRepository,
  })  : _activityRepository = activityRepository,
        _projectRepository = projectRepository,
        super(const ScheduleState()) {
    on<ScheduleProjectsSubscriptionRequested>(_onProjectsSubscriptionRequested);
    on<ScheduleActivitiesSubscriptionRequested>(
        _onActivitiesSubscriptionRequested);
  }

  final ActivityRepository _activityRepository;
  final ProjectRepository _projectRepository;

  Future<void> _onProjectsSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ScheduleStatus.loading));

    await emit.forEach<List<Project>>(
      _projectRepository.getProjectsByUserId(event.userId),
      onData: (projects) => state.copyWith(
        status: ScheduleStatus.success,
        projects: projects,
      ),
      onError: (_, __) => state.copyWith(
        status: ScheduleStatus.failure,
      ),
    );
  }

  Future<void> _onActivitiesSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ScheduleStatus.loading));

    await emit.forEach<List<Activity>>(
      _activityRepository.getActivitiesByDateTime(event.userId, event.dateTime),
      onData: (activities) => state.copyWith(
        status: ScheduleStatus.success,
        activities: activities,
      ),
      onError: (_, __) => state.copyWith(
        status: ScheduleStatus.failure,
      ),
    );
  }
}
