import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/activity.dart';
import '../../../data/repositories/activity_repo.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc({
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        super(const ActivityState()) {
    on<ActivitySubscriptionRequested>(_onSubscriptionRequested);
  }

  final ActivityRepository _activityRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ActivityStatus.loading));

    await emit.forEach<Activity>(
      _activityRepository.getActivityStream(event.id),
      onData: (activity) => state.copyWith(
        status: ActivityStatus.success,
        activity: activity,
      ),
      onError: (_, __) => state.copyWith(
        status: ActivityStatus.failure,
      ),
    );
  }
}
