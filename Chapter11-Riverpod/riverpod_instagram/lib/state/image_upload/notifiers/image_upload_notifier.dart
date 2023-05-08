import 'dart:io';

import 'package:flutter/foundation.dart' show Uint8List;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:riverpod_instagram/state/constants/firebase_collection_name.dart';
import 'package:riverpod_instagram/state/image_upload/constants/constants.dart';
import 'package:riverpod_instagram/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:riverpod_instagram/state/image_upload/extentions/get_collection_name_from_file_type.dart';
import 'package:riverpod_instagram/state/image_upload/extentions/get_image_data_aspect_ratio.dart';
import 'package:riverpod_instagram/state/image_upload/models/file_type.dart';
import 'package:riverpod_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:riverpod_instagram/state/post_setting/models/post_setting.dart';
import 'package:riverpod_instagram/state/posts/models/post_payload.dart';
import 'package:riverpod_instagram/state/posts/typedefs/user_id.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  // it's not loading by default
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required UserId userId,
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSetting,
  }) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;
    switch (fileType) {
      case FileType.image:
        final img.Image? fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }
        // create thumbnail
        final img.Image thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final Uint8List? thumbnail = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.videoThumbnailMaxHeight,
          quality: Constants.videoThumbnailQuality,
        );
        if (thumbnail == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumbnail;
        }
        break;
    }
    // calculate the aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();

    /* calculate references */

    // generate a unique file name
    final fileName = const Uuid().v4();

    // create firebase references to the thumbnail and the image itself
    final Reference thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);
    final Reference originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      // upload the thumbnail
      final TaskSnapshot thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      // upload the original image
      final TaskSnapshot originalFileUploadTask =
          await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      // upload the post itself
      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        postSetting: postSetting,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
