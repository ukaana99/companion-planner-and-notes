part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  final DateTime currentDate;

  const ScheduleState({
    required this.currentDate,
  });

  ScheduleState copyWith({
    DateTime? currentDate,
  }) =>
      ScheduleState(
        currentDate: currentDate ?? this.currentDate,
      );

  @override
  List<Object> get props => [currentDate];

  @override
  String toString() => 'ScheduleState(currentDate: $currentDate)';
}
