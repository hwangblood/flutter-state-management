import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';

part 'can_current_user_delete_provider.g.dart';

@riverpod
Stream<bool> canCurrentUserDeletePost(
  CanCurrentUserDeletePostRef ref, {
  required Post post,
}) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
}
