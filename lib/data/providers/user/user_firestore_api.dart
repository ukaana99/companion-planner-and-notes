import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_api.dart';
import '../../models/user.dart';

class UserFirestoreApi extends UserApi {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _usersRef.doc(id).get();
    return User.fromFire(snapshot);
  }

  @override
  Future<void> createUser(User user) async {
    return _usersRef.doc(user.id).set(user.toJson());
  }

  @override
  Future<void> updateUser(
    String id, {
    String? email,
    String? username,
    String? displayName,
    String? photoUrl,
  }) async {
    Map<String, dynamic> data = {};
    ({
      'email': email,
      'username': username,
      'displayName': displayName,
      'photoUrl': photoUrl,
    }).forEach((key, value) {
      if (value != null) data[key] = value;
    });

    return _usersRef.doc(id).update(data);
  }

  @override
  Future<void> deleteUser(String id) async {
    await _usersRef.doc(id).delete();
  }
}
