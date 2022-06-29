part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class ActivitySubscriptionRequested extends ActivityEvent {
  const ActivitySubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class ActivityActivityDeleted extends ActivityEvent {
  const ActivityActivityDeleted(this.activity);

  final Activity activity;

  @override
  List<Object> get props => [activity];
}

class ActivityUndoDeletionRequested extends ActivityEvent {
  const ActivityUndoDeletionRequested();
}
