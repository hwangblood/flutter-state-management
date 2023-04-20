import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const String userId = 'uid';
  static const String postId = 'post_id';
  static const String comment = 'comment';
  static const String createdAt = 'created_at';
  static const String date = 'date';
  static const String displayName = 'display_name';
  static const String email = 'email';
  const FirebaseFieldName._();
}
