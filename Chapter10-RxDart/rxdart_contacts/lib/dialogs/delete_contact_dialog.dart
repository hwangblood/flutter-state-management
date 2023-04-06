import 'package:flutter/material.dart';
import 'generic_dialog.dart';

Future<bool> showDeleteContactDialog(BuildContext context) {
  return showGenericDialog(
    context,
    title: 'Delete contact',
    content: 'Are you sure you want to delete your contact? You cannot undo '
        'this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then((value) => value ?? false);
}
