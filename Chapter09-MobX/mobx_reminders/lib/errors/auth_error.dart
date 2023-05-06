import 'package:flutter/foundation.dart' show immutable;

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
};

extension _AuthErrorCode on FirebaseAuthException {
  /// Access error code safely
  String get safeCode => code.trim().toLowerCase();

  /// Get title for displaying in a dialog.
  ///
  /// eg. 'user-not-found' => 'User not found'
  String get title =>
      '${code[0].toUpperCase()}${code.substring(1).toLowerCase()}'
          .replaceAll('-', ' ');
}

/// Mapping [Admin Authentication API Errors](https://firebase.google.com/docs/auth/admin/errors)
/// could be throwed to locally [AuthError] class. And more auth error would
/// happen can be found in More [Auth | Firebase JavaScript API reference](https://firebase.google.com/docs/reference/js/auth.md#autherrorcodes)
@immutable
abstract class AuthError {
  final String title;
  final String message;

  const AuthError({
    required this.title,
    required this.message,
  });
  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.safeCode] ?? AuthErrorUnknown(exception);
}

/// Unknown auth error that hasn't mapping to locally [AuthError] class
@immutable
class AuthErrorUnknown extends AuthError {
  final FirebaseAuthException innerException;

  AuthErrorUnknown(this.innerException)
      : super(
          title: innerException.title /* ?? 'Authtication error' */,
          message: innerException.message ?? 'Unknown authtication error',
        );
}

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          title: 'No current user!',
          message: 'No current user with this information was found!',
        );
}

/// auth/requires-recent-login
@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          title: 'Requires recent login',
          message:
              'You need to log out and log back in again in order to perform this operation',
        );
}

/// auth/operation-not-allowed
///
/// This error happens when email-password sign-in method is not enabled,
/// remember to enable it before running the code
@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          title: 'Operation not allowed',
          message: 'You cannot register using this method at this moment!',
        );
}

/// auth/user-not-found
@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          title: 'User not found',
          message: 'The given was not found on the server!',
        );
}

/// auth/weak-password
@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          title: 'Weak pasword',
          message:
              'Please choose a stronger password consisting of more characters!',
        );
}

/// auth/invalid-email
@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          title: 'Invalid email',
          message: 'Please double check your email and try again!',
        );
}

/// auth/email-already-in-use
@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          title: 'Email already in use',
          message: 'Please choose another email to register with!',
        );
}
