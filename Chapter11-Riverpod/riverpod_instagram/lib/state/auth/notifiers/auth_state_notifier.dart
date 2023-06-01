import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/auth/backend/authenticator.dart';
import 'package:riverpod_instagram/state/auth/models/auth_result.dart';
import 'package:riverpod_instagram/state/auth/models/auth_state.dart';
import 'package:riverpod_instagram/state/posts/typedefs/user_id.dart';
import 'package:riverpod_instagram/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  final _authenticator = Authenticator();
  final _userInfoStorage = UserInfoStorage();

  @override
  AuthState build() {
    if (_authenticator.isAlreadyLoggedIn) {
      return AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
    return const AuthState.unknown();
  }

  Future<void> logout() async {
    state = state.copyWithLoading(true);
    await _authenticator.logout();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({
    required UserId userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
