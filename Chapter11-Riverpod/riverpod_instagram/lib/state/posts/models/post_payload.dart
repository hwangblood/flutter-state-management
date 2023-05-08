import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_instagram/state/image_upload/models/file_type.dart';
import 'package:riverpod_instagram/state/post_setting/models/post_setting.dart';
import 'package:riverpod_instagram/state/posts/typedefs/user_id.dart';

import 'post_key.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSetting, bool> postSetting,
  }) : super({
          PostKey.userId: userId,
          PostKey.message: message,
          PostKey.createdAt: FieldValue.serverTimestamp(),
          PostKey.thumbnailUrl: thumbnailUrl,
          PostKey.fileUrl: fileUrl,
          PostKey.fileType: fileType.name,
          PostKey.fileName: fileName,
          PostKey.aspectRatio: aspectRatio,
          PostKey.thumbnailStorageId: thumbnailStorageId,
          PostKey.originalFileStorageId: originalFileStorageId,
          PostKey.postSetting: {
            for (final postSetting in postSetting.entries)
              postSetting.key.storageKey: postSetting.value,
          },
        });
}
