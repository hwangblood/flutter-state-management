import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:riverpod_instagram/state/posts/notifier/delete_post_notifier.dart';

final deletePostProvider = StateNotifierProvider<DeletePostNotifier, IsLoading>(
  (ref) => DeletePostNotifier(),
);
