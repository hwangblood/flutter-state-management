import 'package:flutter/material.dart';

import 'package:riverpod_instagram/state/posts/models/post.dart';

class PostThumbnailWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;

  const PostThumbnailWidget({
    super.key,
    required this.post,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
