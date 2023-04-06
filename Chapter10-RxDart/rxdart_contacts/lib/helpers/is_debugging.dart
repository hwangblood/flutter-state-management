import 'package:flutter/foundation.dart' show kDebugMode;

extension IfDebugging on String {
  /// Only can be used in debug version
  String? get ifDebugging => kDebugMode ? this : null;
}
