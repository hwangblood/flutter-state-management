import 'package:flutter/material.dart';

import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/views/components/post/post_thumbnail_widget.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts.elementAt(index);
        return PostThumbnailWidget(
          post: post,
          onTapped: () {
            // TODO: navigate to post detail page
          },
        );
      },
    );
  }
}
