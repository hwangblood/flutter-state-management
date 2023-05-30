import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/state/user_info/providers/user_info_model_provider.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/rich_two_parts_text.dart';

class PostDisplayNameAndMessageWidget extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(post.userId));

    return userInfoModel.when(
      data: (userInfo) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichTwoPartsText(
            leftPart: userInfo.displayName,
            rightPart: post.message,
          ),
        );
      },
      error: (error, stackTrace) {
        return const SimpleErrorAnimationWidget();
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
