part of 'internet_cubit.dart';

enum ConnectionType { wifi, mobile }

@immutable
abstract class InternetState {
}

class InternetLoading extends InternetState {
  @override
  String toString() => 'InternetLoading()';
}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});

  @override
  String toString() => 'InternetConnected(connectionType: $connectionType)';
}

class InternetDisconnected extends InternetState {
  @override
  String toString() => 'InternetDisconnected()';
}
