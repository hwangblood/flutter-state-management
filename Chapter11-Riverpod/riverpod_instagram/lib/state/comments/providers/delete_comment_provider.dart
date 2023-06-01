import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/comments/notifiers/delete_comment_notifier.dart';
import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';

final deleteCommentProvider =
    NotifierProvider<DeleteCommentNotifier, IsLoading>(
  DeleteCommentNotifier.new,
);
