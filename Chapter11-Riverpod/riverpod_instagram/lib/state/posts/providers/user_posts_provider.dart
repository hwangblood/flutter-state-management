import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/state/posts/models/post_key.dart';

part 'user_posts_provider.g.dart';

@riverpod
Stream<Iterable<Post>> userPosts(UserPostsRef ref) {
  final userId = ref.watch(userIdProvider);

  final controller = StreamController<Iterable<Post>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final streamSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .where(PostKey.userId, isEqualTo: userId)
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final posts = documents
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        )
        .where(
          (post) => post.userId == userId,
        );
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    streamSub.cancel();
    controller.close();
  });

  return controller.stream;
}
