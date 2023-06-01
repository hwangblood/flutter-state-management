import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/comments/models/comment_payload.dart';
import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';
import 'package:riverpod_instagram/state/posts/typedefs/user_id.dart';

class SendCommentNotifier extends Notifier<IsLoading> {
  @override
  bool build() => false;

  set isLoading(value) => state = value;

  /// send a comment, return true if successful, false otherwise
  Future<bool> sendComment({
    required UserId fromUserId,
    required PostId onPostId,
    required String comment,
  }) async {
    final payload = CommentPayload(
      userId: fromUserId,
      postId: onPostId,
      comment: comment,
    );

    try {
      isLoading = true;

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
