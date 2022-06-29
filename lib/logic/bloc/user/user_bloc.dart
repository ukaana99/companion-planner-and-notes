import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserState()) {
    on<UserSubscriptionRequested>(_onSubscriptionRequested);
  }

  final UserRepository _userRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: UserStatus.loading));

    await emit.forEach<User>(
      _userRepository.getUserStream(event.id),
      onData: (user) => state.copyWith(
        status: UserStatus.success,
        user: user,
      ),
      onError: (_, __) => state.copyWith(
        status: UserStatus.failure,
      ),
    );
  }
}
