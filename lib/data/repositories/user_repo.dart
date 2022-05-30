import '../models/user.dart';
import '../providers/user/user_api.dart';

class UserRepository {
  final UserApi _userApi;

  const UserRepository({
    required UserApi userApi,
  }) : _userApi = userApi;

  Future<User> getUser(String id) => _userApi.getUser(id);

  Future<void> createUser(User user) => _userApi.createUser(user);

  Future<void> updateUser(String id, User user) =>
      _userApi.updateUser(id, user);

  Future<void> deleteUser(String id) => _userApi.deleteUser(id);
}
