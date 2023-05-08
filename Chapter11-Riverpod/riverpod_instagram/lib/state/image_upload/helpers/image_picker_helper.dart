import 'dart:io' show File;

import 'package:flutter/foundation.dart' show immutable;

import 'package:image_picker/image_picker.dart';

import 'package:riverpod_instagram/state/image_upload/extentions/xfile_to_file.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageFromGallery() =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile();

  static Future<File?> pickVideoFromGallery() =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
}
