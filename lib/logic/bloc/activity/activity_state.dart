part of 'activity_bloc.dart';

enum ActivityStatus { initial, loading, success, failure }

class ActivityState extends Equatable {
  const ActivityState({
    this.status = ActivityStatus.initial,
    this.activity = const Activity(),
  });

  final ActivityStatus status;
  final Activity activity;

  ActivityState copyWith({
    ActivityStatus? status,
    Activity? activity,
  }) {
    return ActivityState(
      status:  status?? this.status,
      activity:  activity?? this.activity,
    );
  }

  @override
  List<Object?> get props => [status, activity];
}
