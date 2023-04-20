import 'package:flutter/foundation.dart' show immutable;

import 'package:riverpod_instagram/state/auth/models/auth_result.dart';
import 'package:riverpod_instagram/state/posts/typedefs/user_id.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copyWith({
    AuthResult? result,
    bool? isLoading,
    UserId? userId,
  }) {
    return AuthState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
    );
  }

  AuthState copyWithLoading(
    bool isLoading,
  ) =>
      AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}
