import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent {
  const AppEvent();
}

/// What will [AppEventInitial] do?
///
/// For example:
///
/// using cached user token (if existed) to login automatically and load images
/// from Firebase Storage, when you start app.
@immutable
class AppEventInitial implements AppEvent {
  const AppEventInitial();
}

@immutable
class AppEventUploadImage implements AppEvent {
  /// file path in mobile device, which is the image that will be uploaded to
  /// Firebase Storage
  final String filePath;

  const AppEventUploadImage({
    required this.filePath,
  });
}

@immutable
class AppEventDeleteAccount implements AppEvent {
  const AppEventDeleteAccount();
}

@immutable
class AppEventLogOut implements AppEvent {
  const AppEventLogOut();
}

@immutable
class AppEventLogIn implements AppEvent {
  final String email;
  final String password;

  const AppEventLogIn({
    required this.email,
    required this.password,
  });
}

@immutable
class AppEventRegister implements AppEvent {
  final String email;
  final String password;

  const AppEventRegister({
    required this.email,
    required this.password,
  });
}

@immutable
class AppEventNavToRegistration implements AppEvent {
  const AppEventNavToRegistration();
}

@immutable
class AppEventNavToLogin implements AppEvent {
  const AppEventNavToLogin();
}
