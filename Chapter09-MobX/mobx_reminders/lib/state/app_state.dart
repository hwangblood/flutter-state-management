import 'package:firebase_auth/firebase_auth.dart';

abstract class _DocumentKeys {
  static const String text = 'text';
  static const String createAt = 'create_at';
  static const String isDone = 'is_done';
}

typedef LoginOrRegisterFunction = Future<UserCredential> Function({
  required String email,
  required String password,
});
