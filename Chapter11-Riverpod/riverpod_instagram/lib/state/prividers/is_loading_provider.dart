import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:riverpod_instagram/state/image_upload/providers/image_uploader_provider.dart';

import '../comments/providers/delete_comment_provider.dart';
import '../comments/providers/send_comment_provider.dart';

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateProvider);
  final isUploaderLoading = ref.watch(imageUploaderProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deleteCommentProvider);

  return authState.isLoading ||
      isUploaderLoading ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost;
}
