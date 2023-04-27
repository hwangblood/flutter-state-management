import 'package:flutter/foundation.dart' show immutable;

@immutable
class PostSettingConstants {
  static const allowLikesTitle = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes, users will be able to press the like button on your post.';

  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments, users will be able to comment on your post.';

  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsStorageKey = 'allow_comments';
  const PostSettingConstants._();
}
