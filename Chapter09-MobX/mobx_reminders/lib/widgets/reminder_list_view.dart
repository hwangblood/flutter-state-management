import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:mobx_reminders/state/app_state.dart';

import 'reminder_list_tile.dart';

class ReminderListView extends StatelessWidget {
  const ReminderListView({super.key});
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Observer(
      builder: (BuildContext context) {
        return ListView.separated(
          itemCount: appState.sortedReminders.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            final reminder = appState.sortedReminders.elementAt(index);
            return ReminderListTile(reminder: reminder);
          },
        );
      },
    );
  }
}
