import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit()
      : super(const MainState(
          currentIndex: 1,
        ));

  // void setTab(MainTab tab) => emit(state.copyWith(tab: tab));

  void setIndex(int index) => emit(state.copyWith(currentIndex: index));
}
