import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repo.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  void _onUserChanged(event, emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(event, emit) {
    unawaited(_authRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
