import 'package:flutter/foundation.dart' show Uint8List;
import 'package:flutter/material.dart';

import 'package:riverpod/riverpod.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:riverpod_instagram/state/image_upload/constants/constants.dart';
import 'package:riverpod_instagram/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:riverpod_instagram/state/image_upload/extentions/get_image_aspect_ratio.dart';
import 'package:riverpod_instagram/state/image_upload/models/file_type.dart';
import 'package:riverpod_instagram/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:riverpod_instagram/state/image_upload/models/thumbnail_request.dart';

// family() always take <ReturnValue, InputValue> generic class
final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
        (ref, ThumbnailRequest request) async {
  final Image image;

  switch (request.fileType) {
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;
    case FileType.video:
      final Uint8List? thumbnail = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: Constants.videoThumbnailQuality, // 75%
      );
      if (thumbnail == null) {
        throw const CouldNotBuildThumbnailException();
      }
      image = Image.memory(
        thumbnail,
        fit: BoxFit.fitHeight,
      );
  }

  final aspectRatio = await image.getAspectRatio();
  return ImageWithAspectRatio(
    image: image,
    aspectRatio: aspectRatio,
  );
});
