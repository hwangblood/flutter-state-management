import 'package:flutter/foundation.dart' show immutable;

// ignore_for_file: public_member_api_docs, sort_constructors_first

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;
  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
