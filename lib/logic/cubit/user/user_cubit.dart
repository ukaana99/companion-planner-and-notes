import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:companion/data/models/user.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    this.user,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserState(
          user: user ?? const User(),
          displayName: user?.displayName ?? '',
        ));

  final UserRepository _userRepository;
  final User? user;

  void displayNameChanged(String value) =>
      emit(state.copyWith(displayName: value));

  Future<void> updateForm() async {
    final user = state.user?.copyWith(displayName: state.displayName);
    try {
      await _userRepository.updateUser(state.user!.id!, user!);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }
}
