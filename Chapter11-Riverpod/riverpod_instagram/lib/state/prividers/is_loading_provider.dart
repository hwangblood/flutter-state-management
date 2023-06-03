import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:riverpod_instagram/state/image_upload/providers/image_uploader_provider.dart';
import 'package:riverpod_instagram/state/posts/providers/delete_post_provider.dart';

import '../comments/providers/delete_comment_provider.dart';
import '../comments/providers/send_comment_provider.dart';

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  final isUploaderLoading = ref.watch(imageUploaderNotifierProvider);
  final isSendingComment = ref.watch(sendCommentNotifierProvider);
  final isDeletingComment = ref.watch(deleteCommentNotifierProvider);
  final isDeletingPost = ref.watch(deletePostNotifierProvider);

  return authState.isLoading ||
      isUploaderLoading ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost;
}
