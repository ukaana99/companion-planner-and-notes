part of 'main_cubit.dart';

// enum MainTab { dashboard, timetable, program, tasks, note }

class MainState extends Equatable {
  // final MainTab tab;
  final int currentIndex;

  const MainState({
    // required this.tab,
    required this.currentIndex,
  });

  MainState copyWith({
    // MainTab? tab,
    int? currentIndex,
  }) =>
      MainState(
        // tab: tab ?? this.tab,
        currentIndex: currentIndex ?? this.currentIndex,
      );

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() => 'MainState(currentIndex: $currentIndex)';
}
