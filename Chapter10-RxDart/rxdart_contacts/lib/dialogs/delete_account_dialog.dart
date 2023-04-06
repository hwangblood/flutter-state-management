import 'package:flutter/material.dart';
import 'generic_confirm_dialog.dart';
import 'generic_dialog.dart';

/// For delete account operation, this dialog will return a bool value that used
/// to get whether a user want to delete the account or not (true or false)
///
/// Dialogs the user can always dismiss them by tapping area outside of that
/// dialog, or on an android device where you have some hardware buttons for
/// back action, then you can actually tap on the back button and completely
/// ignore the dialog that's been displaed to the user.
///
/// that's why there is a sentence: `then((value) => value ?? false)` after
/// [showGenericDialog], because [showGenericDialog] return a Future with
/// optional generic type `T?`, in this [showDeleteAccountDialog] case will
/// return a `Future<bool?>`, and we actually want returned is `Future<bool>`.
Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog(
    context,
    title: 'Delete account',
    content: 'Are you sure you want to delete your account? You cannot undo '
        'this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then((value) => value ?? false);
}

Future<bool> showDeleteAccountConfirmDialog(BuildContext context) =>
    showGenericConfirmDialog(
      context,
      title: 'Delete account',
      content: 'Are you sure you want to delete your account? You cannot undo '
          'this operation!',
      optionsBuilder: () => {
        'Cancel': false,
        'Delete': true,
      },
    );
