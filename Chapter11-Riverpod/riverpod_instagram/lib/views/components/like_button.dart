import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/likes/models/like_dislike_request.dart';
import 'package:riverpod_instagram/state/likes/providers/has_liked_post_provider.dart';
import 'package:riverpod_instagram/state/likes/providers/like_dislike_post_provider.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(
      hasLikedPostProvider(postId: postId),
    );
    return hasLiked.when(
      data: (likedValue) {
        return IconButton(
          icon: FaIcon(
            likedValue ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          ),
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }

            final likeDislikeRequest = LikeDislikeRequest(
              likedBy: userId,
              postId: postId,
            );

            ref.read(
              likeDislikePostProvider(request: likeDislikeRequest),
            );
          },
        );
      },
      error: (error, stackTrace) => const SimpleErrorAnimationWidget(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
