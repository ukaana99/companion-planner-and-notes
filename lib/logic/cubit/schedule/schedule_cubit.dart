import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit()
      : super(ScheduleState(
          currentDate: DateTime.now(),
        ));

  void setCurrentDate(DateTime currentDate) =>
      emit(state.copyWith(currentDate: currentDate));
}
