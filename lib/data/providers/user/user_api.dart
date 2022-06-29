import '../../models/user.dart';

abstract class UserApi {
  const UserApi();

  Future<User> getUser(String id);

  Stream<User> getUserStream(String id);

  Future<void> createUser(User user);

  Future<void> updateUser(String id, User user);

  Future<void> deleteUser(String id);
}
