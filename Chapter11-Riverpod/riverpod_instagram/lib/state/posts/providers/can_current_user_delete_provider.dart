import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';

final canCurrentUserDeletePostProvider =
    StreamProvider.family.autoDispose<bool, Post>((ref, Post post) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});
