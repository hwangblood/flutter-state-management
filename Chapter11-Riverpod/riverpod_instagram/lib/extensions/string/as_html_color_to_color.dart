import 'package:flutter/material.dart';

import 'package:riverpod_instagram/extensions/string/remove_all.dart';

extension AsHtmlColorToColor on String {
  // convert 0xFF00FF or #ffeecc to [Color]
  /// Examples:
  ///
  /// '#aabbcc' => 'ffaabbcc'
  /// '0xaabbcc' => 'ffaabbcc'
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(['#', '0x']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
