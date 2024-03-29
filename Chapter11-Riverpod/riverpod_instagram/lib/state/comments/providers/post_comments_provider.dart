import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:riverpod_instagram/state/comments/models/comment.dart';
import 'package:riverpod_instagram/state/comments/models/post_comments_request.dart';
import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';

part 'post_comments_provider.g.dart';

@riverpod
Stream<Iterable<Comment>> postComments(
  PostCommentsRef ref, {
  required RequestForPostAndComments request,
}) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    // limit
    final limitedDocuments =
        request.limit != null ? documents.take(request.limit!) : documents;
    // map to Comment
    final comments = limitedDocuments
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (doc) => Comment.fromJson(doc.data(), id: doc.id),
        );
    // sorting
    final result = comments.applySortingFrom(request);

    controller.sink.add(result);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
}
