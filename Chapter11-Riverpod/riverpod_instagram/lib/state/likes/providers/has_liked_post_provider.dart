import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';

/// check if logged user has liked the post or not
final hasLikedPostProvider = StreamProvider.family.autoDispose<bool, PostId>((
  ref,
  PostId postId,
) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) {
    return Stream.value(false);
  }
  final controller = StreamController<bool>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .where(FirebaseFieldName.userId, isEqualTo: userId)
      .snapshots()
      .listen(
        (snapshot) => controller.sink.add(snapshot.docs.isNotEmpty),
      );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
