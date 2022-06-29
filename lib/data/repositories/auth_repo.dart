import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user.dart';
import '../providers/user/user_api.dart';

class SignInFailure implements Exception {}

class SignInWithEmailAndPasswordFailure implements Exception {
  const SignInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class SignOutFailure implements Exception {}

class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final UserApi _userApi;

  AuthRepository({
    required UserApi userApi,
  }) : _userApi = userApi;

  Future<User> get currentUser async => _firebaseAuth.currentUser == null
      ? User.empty
      : await _userApi.getUser(_firebaseAuth.currentUser!.uid);

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().asyncMap((authUser) async {
      return authUser == null
          ? User.empty
          : await _userApi.getUser(authUser.uid);
    });
  }

  Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } catch (_) {
      throw SignInFailure();
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.User authUser = userCredential.user!;

      // create a new document for the user with the uid
      final user = User(
        id: authUser.uid,
        email: email,
      );
      await _userApi.createUser(user);
    } on auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw SignOutFailure();
    }
  }
}

// extension on auth.User {
//   User get toUser {
//     return User(
//       id: uid,
//       email: email,
//       displayName: displayName ?? '',
//       photoUrl: photoURL ?? '',
//     );
//   }
// }
