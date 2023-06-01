import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/image_upload/notifiers/image_upload_notifier.dart';
import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';

final imageUploaderProvider = NotifierProvider<ImageUploadNotifier, IsLoading>(
  ImageUploadNotifier.new,
);
