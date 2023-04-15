import 'package:flutter/foundation.dart' show immutable;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:bloc_photo_gallery/auth/auth_error.dart';

extension GetUserFromState on AppState {
  User? get user {
    final obj = this;
    // only logged-in state has reference to User
    if (obj is AppStateLoggedIn) {
      return obj.user;
    } else {
      return null;
    }
  }
}

extension GetImagesFromState on AppState {
  Iterable<Reference>? get images {
    final obj = this;
    // only logged-in state has reference to images
    if (obj is AppStateLoggedIn) {
      return obj.images;
    } else {
      return null;
    }
  }
}

@immutable
abstract class AppState {
  /// Various operations in different screen could cost some time, so loading
  /// state should work in whole app.
  final bool isLoading;

  /// Various operations in different screen could need authentication
  /// premission, so auth error state should work in whole app.
  final AuthError? authError;

  const AppState({
    required this.isLoading,
    required this.authError,
  });

  @override
  String toString() => 'AppState(isLoading: $isLoading, authError: $authError)';
}

@immutable
class AppStateLoggedIn extends AppState {
  /// Logged Firebase [User]
  final User user;

  /// List for image file [Reference] in Firebase Storage
  final Iterable<Reference> images;

  const AppStateLoggedIn({
    required this.user,
    required this.images,
    required super.isLoading,
    required super.authError,
  });

  @override
  bool operator ==(other) {
    final otherObject = other;
    if (otherObject is AppStateLoggedIn) {
      return isLoading == otherObject.isLoading &&
          user.uid == otherObject.user.uid &&
          images.length == otherObject.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.uid,
        images,
      );

  @override
  String toString() => 'AppStateLoggedIn(user: $user, images: $images)';
}

@immutable
class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({
    required super.isLoading,
    required super.authError,
  });

  @override
  String toString() =>
      'AppStateLoggedOut(isLoading: $isLoading, authError: $authError)';
}

@immutable
class AppStateInRegistrationView extends AppState {
  const AppStateInRegistrationView({
    required super.isLoading,
    required super.authError,
  });
}
