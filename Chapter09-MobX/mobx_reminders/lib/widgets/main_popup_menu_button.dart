import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mobx_reminders/dialogs/delete_account_dialog.dart';
import 'package:mobx_reminders/dialogs/logout_dialog.dart';
import 'package:mobx_reminders/state/app_state.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupMenuButton extends StatelessWidget {
  const MainPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        AppState appState = context.read<AppState>();
        switch (value) {
          case MenuAction.logout:
            final shouldLogOut = await showLogoutDialog(context);
            if (shouldLogOut) {
              appState.logout();
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);
            if (shouldDeleteAccount) {
              appState.deleteAccount();
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text('Log out'),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text('Delete account'),
          ),
        ];
      },
    );
  }
}
