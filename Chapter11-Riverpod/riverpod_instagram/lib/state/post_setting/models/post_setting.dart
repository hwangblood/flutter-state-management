import 'package:riverpod_instagram/state/post_setting/constants/constants.dart';

enum PostSetting {
  /// if allow user to like the current post, true or false, default should as
  /// false
  allowLikes(
    title: PostSettingConstants.allowCommentsTitle,
    description: PostSettingConstants.allowCommentsDescription,
    storageKey: PostSettingConstants.allowCommentsStorageKey,
  ),

  /// if allow user to comment the current post, true or false, default should
  /// as false
  allowComments(
    title: PostSettingConstants.allowLikesTitle,
    description: PostSettingConstants.allowLikesDescription,
    storageKey: PostSettingConstants.allowLikesStorageKey,
  );

  /// Title to be displayed in ui for post setting
  final String title;

  /// Description to be displayed in ui for post setting
  final String description;

  /// Storage Key to be stored in Firestore for post setting
  final String storageKey;

  const PostSetting({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
