import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/comments/notifiers/send_comment_notifier.dart';
import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';

final sendCommentProvider = NotifierProvider<SendCommentNotifier, IsLoading>(
  SendCommentNotifier.new,
);
