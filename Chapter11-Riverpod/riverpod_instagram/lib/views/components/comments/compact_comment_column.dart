import 'package:flutter/material.dart';

import 'package:riverpod_instagram/state/comments/models/comment.dart';
import 'package:riverpod_instagram/views/components/comments/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  final Iterable<Comment> comments;
  const CompactCommentColumn({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments
            .map((comment) => CompactCommentTile(comment: comment))
            .toList(),
      ),
    );
  }
}
