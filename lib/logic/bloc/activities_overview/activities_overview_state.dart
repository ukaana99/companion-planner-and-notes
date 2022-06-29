part of 'activities_overview_bloc.dart';

enum ActivitiesOverviewStatus { initial, loading, success, failure }

class ActivitiesOverviewState extends Equatable {
  const ActivitiesOverviewState({
    this.status = ActivitiesOverviewStatus.initial,
    this.activities = const [],
    this.lastDeletedActivity,
  });

  final ActivitiesOverviewStatus status;
  final List<Activity> activities;
  final Activity? lastDeletedActivity;

  ActivitiesOverviewState copyWith({
    ActivitiesOverviewStatus? status,
    List<Activity>? activities,
    Activity? lastDeletedActivity,
  }) {
    return ActivitiesOverviewState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
      lastDeletedActivity: lastDeletedActivity ?? this.lastDeletedActivity,
    );
  }

  @override
  List<Object?> get props => [status, activities, lastDeletedActivity];
}
