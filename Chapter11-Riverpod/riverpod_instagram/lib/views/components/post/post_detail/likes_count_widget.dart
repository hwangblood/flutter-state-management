import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/likes/providers/post_likes_count_provider.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/constants/strings.dart';

class LikesCountWidget extends ConsumerWidget {
  final PostId postId;

  const LikesCountWidget({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (int count) {
        final personOrPeople = count == 1 ? Strings.person : Strings.people;
        final likesText = '$count $personOrPeople ${Strings.likedThis}';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(likesText),
        );
      },
      error: (error, stackTrace) => const SimpleErrorAnimationWidget(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
