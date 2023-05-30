import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';

final postLikesCountProvider = StreamProvider.autoDispose.family<int, PostId>((
  ref,
  PostId postId,
) {
  final controller = StreamController<int>.broadcast();

  controller.onListen = () {
    // by default, no people liked the post
    controller.sink.add(0);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .snapshots()
      .listen(
        (snapshot) => controller.sink.add(snapshot.docs.length),
      );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
