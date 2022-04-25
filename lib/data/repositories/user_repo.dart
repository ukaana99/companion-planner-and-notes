import '../models/user.dart';
import '../providers/user/user_api.dart';

class UserRepository {
  final UserApi _userApi;

  const UserRepository({
    required UserApi userApi,
  }) : _userApi = userApi;

  Future getUser(String id) => _userApi.getUser(id);
  
  Future createUser(User user) => _userApi.createUser(user);
}
