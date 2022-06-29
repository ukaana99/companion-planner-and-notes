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
        super(const AppState.unknown()) {
    on<AppStarted>(_onStarted);
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  Future<void> _onStarted(event, emit) async {
    final user = await _authRepository.currentUser;
    emit(
      user.isNotEmpty
          ? AppState.authenticated(user)
          : const AppState.unauthenticated(),
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
