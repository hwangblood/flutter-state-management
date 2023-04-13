import 'package:flutter/foundation.dart' show immutable;

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Errors mapping from [Admin Authentication API Errors](https://firebase.google.com/docs/auth/admin/errors)
const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-receent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
};

@immutable
abstract class AuthError {
  final String title;
  final String content;
  const AuthError({
    required this.title,
    required this.content,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      AuthErrorUnknown(
        title: exception.code,
        message: exception.message,
      );
}

/// Unknown auth errro
@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown({String? title, String? message})
      : super(
          title: title ?? 'Authentication error',
          content: message ?? 'Unknown authentication error',
        );
}

/// auth/no-current-user
@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          title: 'No current user!',
          content: 'No current user with this information was found.',
        );
}

/// auth/requires-recent-login
///
/// AuthErrorRequiresRecentLogin happens in few time.
///
/// there is a case:
/// 1. login to app and exit app
/// 2. after some days ago, start the app
/// 3. do some operations like: delete logged user account in app
/// 4. [AuthErrorRequiresRecentLogin] will be happened
/// 5. then, need to re-login for authenticating user account
@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          title: 'Requires recent login',
          content: 'You need to logout and re-login in order to perform this '
              'operation',
        );
}

/// auth/operation-not-allowed
///
/// This error hasppens such as: The Firebase backend has not be enabled email
/// and passsword authtication provider, in this case, if a person want to
/// register a user account from the app, then this error will happen
///
/// also happens, when you're trying to register app with your google account or facebook
/// account, and these providers are not enabled in your firebase console
@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          title: 'Operation not allowed',
          content: 'You cannot register using this method at this moment!',
        );
}

/// auth/user-not-found
///
/// When you trying to login a user that hasn't be registered into your Firebase
/// backend server, error happpens in this case.
@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          title: 'User not found',
          content: 'The given user was not found on the server!',
        );
}

/// auth/weak-password
///
/// Password is too weak, when register
@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          title: 'Weak password',
          content: 'Please choose a stronger password consisting of more '
              'characters!',
        );
}

/// auth/invalid-email
@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          title: 'Invalid email',
          content: 'Please double check your email and try again!',
        );
}

/// auth/email-already-exists
@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          title: 'Email already is use',
          content: 'Please choose another email to register with!',
        );
}
