import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/post_setting/models/post_setting.dart';

part 'post_setting_provider.g.dart';

@riverpod
class PostSettingNotifier extends _$PostSettingNotifier {
  @override
  Map<PostSetting, bool> build() => UnmodifiableMapView(
        {for (final setting in PostSetting.values) setting: true},
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
