import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/user_id_provider.dart';
import 'package:riverpod_instagram/state/comments/models/comment.dart';
import 'package:riverpod_instagram/state/comments/providers/delete_comment_provider.dart';
import 'package:riverpod_instagram/state/user_info/providers/user_info_model_provider.dart';
import 'package:riverpod_instagram/views/components/animations/simple_error_animation_widget.dart';
import 'package:riverpod_instagram/views/components/constants/strings.dart';
import 'package:riverpod_instagram/views/components/dialogs/alert_dialog_model.dart';
import 'package:riverpod_instagram/views/components/dialogs/delete_dialog.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('mm: ${comment.fromUserId}');
    final userInfo = ref.watch(
      userInfoModelProvider(comment.fromUserId),
    );
    return userInfo.when(
      data: (userInfo) {
        final currentUserId = ref.read(userIdProvider);
        print('comment tile: ${comment.comment}');
        return ListTile(
          title: Text(userInfo.displayName),
          subtitle: Text(comment.comment),
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final shouldDeleteComment =
                        await displayDeleteDialog(context);
                    if (shouldDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                )
              : null,
        );
      },
      error: (error, stackTrace) {
        return const SimpleErrorAnimationWidget();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then(
            (value) => value ?? false,
          );
}
