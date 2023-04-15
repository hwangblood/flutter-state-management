import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/// Upload image [file] to Storage folder that named as [userId], If the
/// uploading is successful, return true. Otherwise, return false
Future<bool> uploadImage({
  required String userId,
  required File file,
}) =>
    FirebaseStorage.instance
        .ref(userId)
        // set a random uuid for file name
        .child(const Uuid().v4())
        .putFile(file)
        .then((_) => true)
        .catchError((_) => false);
