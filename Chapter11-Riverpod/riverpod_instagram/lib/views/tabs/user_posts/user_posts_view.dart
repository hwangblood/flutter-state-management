import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/posts/providers/user_posts_provider.dart';
import 'package:riverpod_instagram/views/components/animations/empty_content_with_text_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/loading_animation_widget.dart';
import 'package:riverpod_instagram/views/components/post/posts_grid_view.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';

class UerPostsView extends ConsumerWidget {
  const UerPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      child: posts.when(
        data: (postsList) {
          if (postsList.isEmpty) {
            return const EmptyContentWithTextAnimationWidget(
              text: Strings.youHaveNoPosts,
            );
          } else {
            return PostsGridView(posts: postsList);
          }
        },
        error: (error, stackTrace) => const ErrorAnimationWidget(),
        loading: () => const LoadingAnimationWidget(),
      ),
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
    );
  }
}
