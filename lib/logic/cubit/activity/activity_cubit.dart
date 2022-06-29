import 'package:bloc/bloc.dart';
import 'package:companion/data/models/activity.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/activity_repo.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit({
    this.activity,
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        super(ActivityState(
          activity: activity ?? const Activity(),
          title: activity?.title ?? '',
          description: activity?.description ?? '',
          colorHex: activity?.colorHex ?? '0xffffffff',
          isRepeated: activity?.isRepeated ?? false,
          daysRepeated: activity?.daysRepeated ??
              [false, false, false, false, false, false, false],
          dateTime: activity?.dateTime ?? DateTime.now(),
          projectId: activity?.projectId ?? '',
        ));

  final ActivityRepository _activityRepository;
  final Activity? activity;

  void titleChanged(String value) => emit(state.copyWith(title: value));

  void descriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void colorChanged(String value) => emit(state.copyWith(colorHex: value));

  void isRepeatedChanged(bool value) => emit(state.copyWith(isRepeated: value));

  void daysRepeatedChanged(int index) {
    final value = List<bool>.from(state.daysRepeated);
    value[index] = !value[index];

    emit(state.copyWith(daysRepeated: value));
  }

  void dateTimeChanged(DateTime value) => emit(state.copyWith(dateTime: value));

  void projectIdChanged(String? value) =>
      emit(state.copyWith(projectId: value));

  Future<void> submitForm(String userId, {String? projectId}) async {
    final activity = Activity(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
      isRepeated: state.isRepeated,
      daysRepeated: state.isRepeated ? state.daysRepeated : [],
      dateTime: state.isRepeated ? null : state.dateTime,
      projectId: projectId ?? state.projectId,
      userId: userId,
    );
    try {
      await _activityRepository.createActivity(activity);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }

  Future<void> updateForm() async {
    final activity = state.activity?.copyWith(
      title: state.title,
      description: state.description,
      colorHex: state.colorHex,
      isRepeated: state.isRepeated,
      daysRepeated: state.isRepeated ? state.daysRepeated : [],
      dateTime: state.isRepeated ? null : state.dateTime,
    );
    try {
      await _activityRepository.updateActivity(state.activity!.id!, activity!);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }
}
