import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then((value) => value ?? false);
}

Future<bool> showLogoutConfirmDialog(BuildContext context) =>
    showGenericConfirmDialog(
      context,
      title: 'Log out',
      content: 'Are you sure you want to log out?',
      optionsBuilder: () => {
        'Cancel': false,
        'Log out': true,
      },
    );
