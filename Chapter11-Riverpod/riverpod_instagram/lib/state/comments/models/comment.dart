import 'package:flutter/foundation.dart' show immutable;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_instagram/state/comments/typedefs/comment_id.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';
import 'package:riverpod_instagram/state/posts/typedefs/user_id.dart';

@immutable
class Comment {
  final CommentId id;
  final String comment;
  final DateTime createdAt;
  final UserId fromUserId;
  final PostId onPostId;

  Comment.fromJson(Map<String, dynamic> json, {required this.id})
      : comment = json[FirebaseFieldName.comment] as String,
        createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldName.userId] as UserId,
        onPostId = json[FirebaseFieldName.postId] as PostId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          comment == other.comment &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId;

  @override
  int get hashCode => Object.hashAll([
        id,
        comment,
        createdAt,
        fromUserId,
        onPostId,
      ]);
}
