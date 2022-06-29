import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/activity.dart';
import '../../../data/repositories/activity_repo.dart';

part 'activities_overview_event.dart';
part 'activities_overview_state.dart';

class ActivitiesOverviewBloc extends Bloc<ActivitiesOverviewEvent, ActivitiesOverviewState> {
  ActivitiesOverviewBloc({
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        super(const ActivitiesOverviewState()) {
    on<ActivitiesOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<ActivitiesOverviewActivityDeleted>(_onActivityDeleted);
    on<ActivitiesOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final ActivityRepository _activityRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ActivitiesOverviewStatus.loading));

    await emit.forEach<List<Activity>>(
      _activityRepository.getActivitiesByProjectId(event.projectId),
      onData: (activities) => state.copyWith(
        status: ActivitiesOverviewStatus.success,
        activities: activities,
      ),
      onError: (_, __) => state.copyWith(
        status: ActivitiesOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onActivityDeleted(event, emit) async {
    emit(state.copyWith(lastDeletedActivity: event.activity));
    await _activityRepository.deleteActivity(event.activity.id);
  }

  Future<void> _onUndoDeletionRequested(event, emit) async {
    assert(
      state.lastDeletedActivity != null,
      'Last deleted activity can not be null.',
    );

    final activity = state.lastDeletedActivity!;
    emit(state.copyWith(lastDeletedActivity: null));
    await _activityRepository.createActivity(activity);
  }
}
