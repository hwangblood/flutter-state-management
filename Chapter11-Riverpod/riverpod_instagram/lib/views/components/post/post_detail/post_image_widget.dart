import 'package:flutter/material.dart';

import 'package:riverpod_instagram/state/posts/models/post.dart';

class PostImageWidget extends StatelessWidget {
  final Post post;
  const PostImageWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
