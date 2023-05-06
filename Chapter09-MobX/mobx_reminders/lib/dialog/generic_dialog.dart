import 'package:flutter/material.dart';

/// A Builder Function that generating actions for an [AlertDialog], the key of
/// map will be displayed as title in a [TextButton], and the value typed with
/// T? will be returned from [AlertDialog].
typedef DialogOptionsBuilder<T> = Map<String, T?> Function();

/// Show a generic dialog with title and content, and generating actions by a
/// [DialogOptionsBuilder].
Future<T?> showGenericDialog<T>(
  BuildContext context, {
  required String title,
  required String content,
  required DialogOptionsBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}

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
  required DialogOptionsBuilder optionsBuilder,
}) {
  return showGenericDialog(
    context,
    title: title,
    content: content,
    optionsBuilder: optionsBuilder,
  ).then((value) => value ?? false);
}
