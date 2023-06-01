import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/state/posts/typedefs/search_term.dart';

part 'posts_by_search_term_provider.g.dart';

@riverpod
Stream<Iterable<Post>> postsBySearchTerm(
  PostsBySearchTermRef ref, {
  required SearchTerm searchTerm,
}) {
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((snapshot) {
    final posts = snapshot.docs
        .map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        )
        .where(
          (post) => post.message.toLowerCase().contains(
                searchTerm.toLowerCase(),
              ),
        );
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
}
