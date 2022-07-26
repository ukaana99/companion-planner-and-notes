part of 'user_cubit.dart';

class UserState extends Equatable {
  final User? user;
  final String displayName;

  const UserState({
    this.user,
    this.displayName = '',
  });

  @override
  List<Object> get props =>  [displayName];

  UserState copyWith({
    User? user,
    String? displayName,
  }) {
    return UserState(
      user: user ?? this.user,
      displayName: displayName ?? this.displayName,
    );
  }
}
