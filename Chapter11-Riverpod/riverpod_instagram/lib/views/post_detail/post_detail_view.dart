import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:riverpod_instagram/state/comments/models/post_comments_request.dart';
import 'package:riverpod_instagram/state/enums/date_sorting.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/state/posts/providers/can_current_user_delete_provider.dart';
import 'package:riverpod_instagram/state/posts/providers/delete_post_provider.dart';
import 'package:riverpod_instagram/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/comments/compact_comment_column.dart';
import 'package:riverpod_instagram/views/components/dialogs/alert_dialog_model.dart';
import 'package:riverpod_instagram/views/components/dialogs/delete_dialog.dart';
import 'package:riverpod_instagram/views/components/like_button.dart';
import 'package:riverpod_instagram/views/components/post/post_detail/likes_count_widget.dart';
import 'package:riverpod_instagram/views/components/post/post_detail/post_date_widget.dart';
import 'package:riverpod_instagram/views/components/post/post_detail/post_display_name_and_message_widget.dart';
import 'package:riverpod_instagram/views/components/post/post_detail/post_image_or_video_widget.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';
import 'package:riverpod_instagram/views/post_comments/post_commments_view.dart';

class PostDetailView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailView({
    super.key,
    required this.post,
  });

  static MaterialPageRoute route({required Post post}) => MaterialPageRoute(
        builder: (BuildContext context) => PostDetailView(post: post),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3, // limit for comments
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );

    // get the actual post together with its comments
    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(request),
    );

    // can delete this post or not
    final canDeletePost = ref.watch(
      canCurrentUserDeletePostProvider(widget.post),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          // share button is always present
          postWithComments.when(
            data: (postWithCommentsData) {
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  final url = postWithCommentsData.post.fileUrl;
                  Share.share(url, subject: Strings.checkOutThisPost);
                },
              );
            },
            error: (error, stackTrace) => const SimpleErrorAnimationWidget(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          // delete button or no delete button, check if user is the owner of this post
          if (canDeletePost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirmDelete =
                    await DeleteDialog(titleOfObjectToDelete: Strings.post)
                        .present(context)
                        .then((value) => value ?? false);
                if (!confirmDelete) {
                  return;
                }

                // start deleting
                final deletePostNotifier =
                    ref.read(deletePostProvider.notifier);
                final successed = await deletePostNotifier.deletePost(
                  post: widget.post,
                );

                // check if the delete was successful
                if (context.mounted) {
                  if (successed) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Delete post successful'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Delete post failed'),
                      ),
                    );
                  }
                }
              },
            ),
        ],
      ),
      body: postWithComments.when(
        data: (postWithCommentsData) {
          final postId = postWithCommentsData.post.postId;
          return SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoWidget(post: postWithCommentsData.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // like button if post allows to be liked
                    if (postWithCommentsData.post.allowsLikes)
                      LikeButton(postId: postId),
                    // comment button if post allows to be commentted
                    if (postWithCommentsData.post.allowsComments)
                      IconButton(
                        icon: const Icon(Icons.mode_comment_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PostCommentsView.route(postId: postId),
                          );
                        },
                      ),
                  ],
                ),

                // post details (show divider at bottom)
                PostDisplayNameAndMessageWidget(
                  post: postWithCommentsData.post,
                ),
                PostDateWidget(dateTime: postWithCommentsData.post.createdAt),

                // divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                ),

                // three comments
                CompactCommentColumn(comments: postWithCommentsData.comments),

                // if allow to like, display likes count message
                if (postWithCommentsData.post.allowsLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LikesCountWidget(postId: postId),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const SimpleErrorAnimationWidget(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
