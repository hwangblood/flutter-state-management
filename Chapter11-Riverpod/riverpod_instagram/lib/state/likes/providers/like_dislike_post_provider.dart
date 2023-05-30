import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/likes/models/like_dislike_request.dart';
import 'package:riverpod_instagram/state/likes/models/like_model.dart';

/// send like or dislike request to firebase
final likeDislikePostProvider =
    FutureProvider.family.autoDispose<bool, LikeDislikeRequest>((
  ref,
  LikeDislikeRequest request,
) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .where(FirebaseFieldName.userId, isEqualTo: request.likedBy)
      .get();
  // first check if the user has already liked the post or not
  final hasLiked = await query.then(
    (snapshot) => snapshot.docs.isNotEmpty,
  );

  if (hasLiked) {
    // dislike the post
    try {
      await query.then((snapshot) async {
        for (final doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  } else {
    // like the post
    final like = LikeModel(
      postId: request.postId,
      userId: request.likedBy,
      date: DateTime.now(),
    );

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(like);
      return true;
    } catch (_) {
      return false;
    }
  }
});
