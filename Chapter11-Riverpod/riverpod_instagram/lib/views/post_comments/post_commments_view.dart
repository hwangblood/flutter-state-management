import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/comments/models/post_comments_request.dart';
import 'package:riverpod_instagram/state/comments/providers/post_comments_provider.dart';
import 'package:riverpod_instagram/state/comments/providers/send_comment_provider.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';
import 'package:riverpod_instagram/views/components/animations/empty_content_with_text_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/loading_animation_widget.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/comments/comment_tile.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';
import 'package:riverpod_instagram/views/extensions/dismiss_keyboard.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;

  static MaterialPageRoute route({
    required PostId postId,
  }) =>
      MaterialPageRoute(
        builder: (context) => PostCommentsView(
          postId: postId,
        ),
      );

  const PostCommentsView({
    super.key,
    required this.postId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(
      RequestForPostAndComments(postId: postId),
    );

    final comments = ref.watch(
      postCommentsProvider(request: request.value),
    );

    useEffect(
      () {
        commentController.addListener(() {
          hasText.value = commentController.text.isNotEmpty;
        });
        return () => {};
      },
      [commentController],
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      context: context,
                      controller: commentController,
                      ref: ref,
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: comments.when(
              data: (data) {
                if (data.isEmpty) {
                  return const SingleChildScrollView(
                    child: EmptyContentWithTextAnimationWidget(
                      text: Strings.noCommentsYet,
                    ),
                  );
                }

                return RefreshIndicator(
                  child: ListView.separated(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(8.0),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final comment = data.elementAt(index);
                      return CommentTile(comment: comment);
                    },
                  ),
                  onRefresh: () {
                    // ignore: unused_result
                    ref.refresh(
                      postCommentsProvider(request: request.value),
                    );

                    return Future.delayed(const Duration(seconds: 1));
                  },
                );
              },
              error: (error, stackTrace) => const SimpleErrorAnimationWidget(),
              loading: () => const LoadingAnimationWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: commentController,
              textInputAction: TextInputAction.send,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _submitCommentWithController(
                    context: context,
                    controller: commentController,
                    ref: ref,
                  );
                }
              },
              decoration: const InputDecoration(
                hintText: Strings.writeYourCommentHere,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitCommentWithController({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController controller,
  }) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('send comment failed'),
        ),
      );
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text,
        );

    if (isSent && context.mounted) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
