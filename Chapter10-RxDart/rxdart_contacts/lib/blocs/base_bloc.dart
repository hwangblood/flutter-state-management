import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class BaseBloc {
  const BaseBloc();

  /// Dispose resources or repositories of the Bloc
  void dispose();
}
