import 'package:flutter/material.dart';

import 'package:bloc_photo_gallery/auth/auth_error.dart';

import 'generic_dialog.dart';

Future<void> showAuthErrorDialog(
  BuildContext context, {
  required AuthError authError,
}) {
  return showGenericDialog(
    context,
    title: authError.title,
    content: authError.message,
    optionsBuilder: () => {'OK': true},
  );
}
