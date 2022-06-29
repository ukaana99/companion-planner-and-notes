part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class ScheduleProjectsSubscriptionRequested extends ScheduleEvent {
  const ScheduleProjectsSubscriptionRequested(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}

class ScheduleActivitiesSubscriptionRequested extends ScheduleEvent {
  const ScheduleActivitiesSubscriptionRequested(this.userId, this.dateTime);

  final String userId;
  final DateTime dateTime;

  @override
  List<Object> get props => [userId, dateTime];
}
