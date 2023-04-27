import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => widget,
      // fullscreenDialog: true,
    ),
  );
}
