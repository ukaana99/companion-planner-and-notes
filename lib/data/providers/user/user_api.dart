import '../../models/user.dart';

abstract class UserApi {
  const UserApi();

  Future<User> getUser(String id);

  Future<void> createUser(User user);

  Future<void> updateUser(String id);

  Future<void> deleteUser(String id);
}
