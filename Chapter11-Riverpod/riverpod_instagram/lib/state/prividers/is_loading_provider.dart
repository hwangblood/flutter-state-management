import 'package:riverpod/riverpod.dart';
import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).isLoading;
});
