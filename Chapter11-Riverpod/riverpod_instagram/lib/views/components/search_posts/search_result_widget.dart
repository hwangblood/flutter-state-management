import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/posts/providers/posts_by_search_term_provider.dart';
import 'package:riverpod_instagram/state/posts/typedefs/search_term.dart';
import 'package:riverpod_instagram/views/components/animations/data_not_found_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/empty_content_with_text_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/loading_animation_widget.dart';
import 'package:riverpod_instagram/views/components/post/posts_sliver_grid_view.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';

class SearchResultWidget extends ConsumerWidget {
  final SearchTerm searchTerm;
  const SearchResultWidget({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentWithTextAnimationWidget(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }

    final posts = ref.watch(
      postsBySearchTermProvider(searchTerm: searchTerm),
    );
    return posts.when(
      data: (postsData) {
        if (postsData.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimationWidget(),
          );
        }

        return PostsSliverGridView(posts: postsData);
      },
      error: (error, stacktrace) => const SliverToBoxAdapter(
        child: ErrorAnimationWidget(),
      ),
      loading: () => const SliverToBoxAdapter(
        child: LoadingAnimationWidget(),
      ),
    );
  }
}
