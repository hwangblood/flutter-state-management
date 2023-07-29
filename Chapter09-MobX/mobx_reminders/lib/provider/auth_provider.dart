import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx_reminders/errors/auth_error.dart';

/// AuthProvider should only be used to do things that are related to authentication
abstract class AuthProvider {
  /// if the user is logged in
  String? get userId;

  /// delete the user account, also log out, return result true (success) and false (failure)
  Future<bool> deleteAccountAndSignOut();

  /// log user out
  Future<void> signOut();

  /// create a new user account with email and password, return true for success, otherwise return false
  Future<bool> register({
    required String email,
    required String password,
  });

  /// log a user in with email and password, return true for success, otherwise return false
  Future<bool> login({
    required String email,
    required String password,
  });
}

class FirebaseAuthProvider extends AuthProvider {
  @override
  Future<bool> deleteAccountAndSignOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      return false;
    }

    try {
      // delete the current user
      await user.delete();
      // log the current user out
      await auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (_) {
      rethrow;
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (_) {
      rethrow;
    }
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (_) {
      // we are ignoring the error here
    }
  }

  @override
  String? get userId => FirebaseAuth.instance.currentUser?.uid;
}
