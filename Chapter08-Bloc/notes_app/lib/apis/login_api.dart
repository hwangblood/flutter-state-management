import 'package:flutter/foundation.dart' show immutable;
import 'package:notes_app/models.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  // Singleton pattern
  const LoginApi._sharedInstance();
  static const LoginApi _shared = LoginApi._sharedInstance();

  factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => (email == 'hwangblood@gmail.com' && password == 'asdfghjkl'),
    ).then(
      (isLoggedIn) => isLoggedIn ? const LoginHandle.hwangblood() : null,
    );
  }
}
