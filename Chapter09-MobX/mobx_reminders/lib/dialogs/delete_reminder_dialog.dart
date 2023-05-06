import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showDeleteReminderDialog(BuildContext context) {
  return showGenericDialog(
    context,
    title: 'Delete reminder',
    content: 'Are you sure you want to delete your account? You cannot undo '
        'this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then((value) => value ?? false);
}

Future<bool> showDeleteReminderConfirmDialog(BuildContext context) =>
    showGenericConfirmDialog(
      context,
      title: 'Delete reminder',
      content: 'Are you sure you want to delete this reminder? You cannot undo '
          'this operation!',
      optionsBuilder: () => {
        'Cancel': false,
        'Delete': true,
      },
    );
