part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserSubscriptionRequested extends UserEvent {
  const UserSubscriptionRequested(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class UserUserDeleted extends UserEvent {
  const UserUserDeleted(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class UserUndoDeletionRequested extends UserEvent {
  const UserUndoDeletionRequested();
}
