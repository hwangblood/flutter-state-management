import 'package:flutter/foundation.dart' show kDebugMode;

extension IfDebugging on String {
  /// Only valid in debug mode, this is useful for TextField or
  /// TextEditingController
  String? get ifDebugging => kDebugMode ? this : null;
}
