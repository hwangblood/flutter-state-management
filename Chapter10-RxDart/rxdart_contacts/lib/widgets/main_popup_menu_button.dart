// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:rxdart_contacts/type_defs.dart';

import '../dialogs/delete_account_dialog.dart';
import '../dialogs/logout_dialog.dart';

enum MenuAction {
  logout,
  deleteAccount,
}

class MainPopupMenuButton extends StatelessWidget {
  final LogoutCallback logout;

  final DeleteAccountCallback deleteAccount;

  const MainPopupMenuButton({
    Key? key,
    required this.logout,
    required this.deleteAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final shouldLogout = await showLogoutConfirmDialog(context);
            if (shouldLogout) {
              logout();
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount =
                await showDeleteAccountConfirmDialog(context);
            if (shouldDeleteAccount) {
              deleteAccount();
            }
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text(
              'Logout',
            ),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text(
              'Delete Account',
            ),
          ),
        ];
      },
    );
  }
}
