import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/constants/firebase_field_name.dart';
import 'package:riverpod_instagram/state/image_upload/extentions/get_collection_name_from_file_type.dart';
import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:riverpod_instagram/state/posts/models/post.dart';
import 'package:riverpod_instagram/state/posts/typedefs/post_id.dart';

part 'delete_post_provider.g.dart';

@riverpod
class DeletePostNotifier extends _$DeletePostNotifier {
  @override
  IsLoading build() => false;

  set isLoading(IsLoading value) => state = value;

  Future<bool> deletePost({required Post post}) async {
    try {
      isLoading = true;
      // delete the post's thumbnail
      await FirebaseStorage.instance
          .ref()
          // the storage folder of the post user
          .child(post.userId)
          // thumbnails storage folder of the post user
          .child(FirebaseCollectionName.thumbnails)
          // get the reference to the thumbnail file
          .child(post.thumbnailStorageId)
          .delete();

      // delete the post's original file (image or video)
      await FirebaseStorage.instance
          .ref()
          // the storage folder of the post user
          .child(post.userId)
          // original file storage folder of the post user
          .child(post.fileType.collectionName)
          // get the reference to the original file
          .child(post.originalFileStorageId)
          .delete();

      // delete all comments associated with the post
      await _deleteAllDocuments(
        postId: post.postId,
        fromCollection: FirebaseCollectionName.comments,
      );

      // delete all likes associated with the post
      await _deleteAllDocuments(
        postId: post.postId,
        fromCollection: FirebaseCollectionName.likes,
      );

      // finally delete the post itself

      final postInCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          // we are using the document id as our post's id
          .where(FieldPath.documentId, isEqualTo: post.postId)
          .limit(1)
          .get();

      for (var doc in postInCollection.docs) {
        await doc.reference.delete();
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteAllDocuments({
    required PostId postId,
    required String fromCollection,
  }) =>
      FirebaseFirestore.instance.runTransaction(
        maxAttempts: 3, // try to do this three times, if it fails
        timeout: const Duration(seconds: 20),
        (transaction) async {
          final query = await FirebaseFirestore.instance
              .collection(fromCollection)
              .where(FirebaseFieldName.postId, isEqualTo: postId)
              .get();

          for (final doc in query.docs) {
            transaction.delete(doc.reference);
          }
        },
      );
}
