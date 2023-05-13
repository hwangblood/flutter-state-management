import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/comments/typedefs/comment_id.dart';
import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';

class DeleteCommentNotifier extends StateNotifier<IsLoading> {
  DeleteCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  /// delete a comment, return true if successful, false otherwise
  Future<bool> deleteComment({
    required CommentId commentId,
  }) async {
    try {
      isLoading = true;

      final query = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .where(FieldPath.documentId, isEqualTo: commentId)
          .limit(1) // we want to delete only one comment
          .get();

      await query.then((value) async {
        // there should be only one document
        for (final doc in value.docs) {
          await doc.reference.delete();
        }
      });

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
