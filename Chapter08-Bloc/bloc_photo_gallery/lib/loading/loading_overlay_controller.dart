import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingOverlay = bool Function();
typedef UpdateLoadingOverlay = bool Function(String text);

@immutable
class LoadingOverlayController {
  final CloseLoadingOverlay close;
  final UpdateLoadingOverlay update;
  const LoadingOverlayController({
    required this.close,
    required this.update,
  });
}
