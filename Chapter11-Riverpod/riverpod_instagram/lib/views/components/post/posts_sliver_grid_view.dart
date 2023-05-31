import 'package:flutter/material.dart';

import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/views/components/post/post_thumbnail_widget.dart';
import 'package:riverpod_instagram/views/post_detail/post_detail_view.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsSliverGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final post = posts.elementAt(index);
          return PostThumbnailWidget(
            post: post,
            onTapped: () {
              Navigator.of(context).push(
                PostDetailView.route(post: post),
              );
            },
          );
        },
      ),
    );
  }
}
