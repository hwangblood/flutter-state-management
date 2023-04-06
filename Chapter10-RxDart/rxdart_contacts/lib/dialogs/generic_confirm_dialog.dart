import 'package:flutter/material.dart';

import 'generic_dialog.dart';

/// Always return true or false when tapping on action buttons of dialog.
///
/// Dialogs the user can always dismiss them by tapping area outside of that
/// dialog, or on an android device where you have some hardware buttons for
/// back action, then you can actually tap on the back button and completely
/// ignore the dialog that's been displaed to the user.
///
/// that's why there is a sentence: `then((value) => value ?? false)` after
/// [showGenericDialog], because [showGenericDialog] return a Future with
/// optional generic type `T?`, such as: in delete user account case will return
/// a `Future<bool?>`, and we actually want returned is `Future<bool>`.
Future<bool> showGenericConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  return showGenericDialog(
    context,
    title: title,
    content: content,
    optionsBuilder: optionsBuilder,
  ).then((value) => value ?? false);
}
