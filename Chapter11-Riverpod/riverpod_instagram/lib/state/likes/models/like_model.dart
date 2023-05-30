import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;

import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';
import 'package:riverpod_instagram/state/posts/typedefs/user_id.dart';

@immutable
class LikeModel extends MapView<String, String> {
  LikeModel({
    required PostId postId,
    required UserId userId,
    required DateTime date,
  }) : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.date: date.toIso8601String(),
        });
}
