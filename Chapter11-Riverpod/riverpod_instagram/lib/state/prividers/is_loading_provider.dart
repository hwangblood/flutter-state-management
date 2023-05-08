import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:riverpod_instagram/state/image_upload/providers/image_uploader_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final isAuthLoading = ref.watch(authStateProvider).isLoading;
  final isUploaderLoading = ref.watch(imageUploaderProvider);
  return isAuthLoading || isUploaderLoading;
});
