import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/post_setting/models/post_setting.dart';
import 'package:riverpod_instagram/state/post_setting/notifiers/post_setting_notifier.dart';

final postSettingProvider =
    NotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
  PostSettingNotifier.new,
);
