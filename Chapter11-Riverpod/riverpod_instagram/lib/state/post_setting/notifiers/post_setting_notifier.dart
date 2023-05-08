import 'dart:collection';

import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/post_setting/models/post_setting.dart';

class PostSettingNotifier extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingNotifier()
      : super(
          UnmodifiableMapView(
            {for (final setting in PostSetting.values) setting: true},
          ),
        );

  void setSetting(
    PostSetting setting,
    bool value,
  ) {
    final existedValue = state[setting];
    if (existedValue == null || existedValue == value) {
      return;
    }
    // update state from old state
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}
