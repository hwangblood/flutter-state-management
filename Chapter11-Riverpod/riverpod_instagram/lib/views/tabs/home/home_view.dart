import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/posts/providers/all_posts_provider.dart';
import 'package:riverpod_instagram/views/components/animations/empty_content_with_text_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/loading_animation_widget.dart';
import 'package:riverpod_instagram/views/components/post/posts_grid_view.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(allPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (postsData) {
          if (postsData.isEmpty) {
            return const EmptyContentWithTextAnimationWidget(
              text: Strings.noPostsAvailable,
            );
          }
          return PostsGridView(posts: postsData);
        },
        error: (error, stackTrace) => const ErrorAnimationWidget(),
        loading: () => const LoadingAnimationWidget(),
      ),
    );
  }
}
