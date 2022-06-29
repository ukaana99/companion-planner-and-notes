part of 'activities_overview_bloc.dart';

abstract class ActivitiesOverviewEvent extends Equatable {
  const ActivitiesOverviewEvent();

  @override
  List<Object> get props => [];
}

class ActivitiesOverviewSubscriptionRequested extends ActivitiesOverviewEvent {
  const ActivitiesOverviewSubscriptionRequested(this.projectId);

  final String projectId;

  @override
  List<Object> get props => [projectId];
}

class ActivitiesOverviewActivityDeleted extends ActivitiesOverviewEvent {
  const ActivitiesOverviewActivityDeleted(this.activity);

  final Activity activity;

  @override
  List<Object> get props => [activity];
}

class ActivitiesOverviewUndoDeletionRequested extends ActivitiesOverviewEvent {
  const ActivitiesOverviewUndoDeletionRequested();
}
