import 'package:flutter/foundation.dart' show immutable;

import 'package:collection/collection.dart';

import 'package:riverpod_instagram/state/comments/models/comment.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';

@immutable
class PostWithComments {
  final Post post;
  final Iterable<Comment> comments;
  const PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  bool operator ==(covariant PostWithComments other) {
    return other.post == post &&
        const IterableEquality().equals(
          comments,
          other.comments,
        );
  }

  @override
  int get hashCode => Object.hashAll([
        post.hashCode,
        comments.hashCode,
      ]);
}
