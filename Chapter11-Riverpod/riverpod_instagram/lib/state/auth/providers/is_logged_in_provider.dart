import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/auth/models/auth_result.dart';
import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
