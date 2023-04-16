import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_photo_gallery/bloc/app_bloc.dart';
import 'package:bloc_photo_gallery/bloc/app_event.dart';
import 'package:bloc_photo_gallery/dialogs/delete_account_dialog.dart';
import 'package:bloc_photo_gallery/dialogs/logout_dialog.dart';

enum MenuAction {
  logout,
  deleteAccount,
}

class MainPopupMenuButton extends StatelessWidget {
  const MainPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (menuAction) async {
        // How to satisfy "Do not use BuildContexts across async gaps" in a stateless widget with an async callback?
        // https://github.com/flutter/flutter/issues/110694
        final appBloc = context.read<AppBloc>();
        switch (menuAction) {
          case MenuAction.logout:
            final yesOrNo = await showLogOutConfirmDialog(context);
            if (yesOrNo) {
              appBloc.add(
                const AppEventLogOut(),
              );
            }
            break;
          case MenuAction.deleteAccount:
            final yesOrNo = await showDeleteAccountConfirmDialog(context);
            if (yesOrNo) {
              appBloc.add(
                const AppEventDeleteAccount(),
              );
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text('Log out'),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text('Delete account'),
          ),
        ];
      },
    );
  }
}
