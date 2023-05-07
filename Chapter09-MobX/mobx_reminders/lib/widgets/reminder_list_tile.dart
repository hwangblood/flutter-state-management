import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mobx_reminders/dialogs/delete_reminder_dialog.dart';
import 'package:mobx_reminders/state/app_state.dart';
import 'package:mobx_reminders/state/reminder.dart';

class ReminderListTile extends StatelessWidget {
  const ReminderListTile({
    super.key,
    required this.reminder,
  });

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        context.read<AppState>().modify(reminder, isDone: value ?? false);
        reminder.isDone = value ?? false;
      },
      value: reminder.isDone,
      title: Row(
        children: [
          Expanded(
            child: Text(reminder.text),
          ),
          IconButton(
            onPressed: () async {
              final appState = context.read<AppState>();
              final result = await showDeleteReminderDialog(context);
              if (result) {
                appState.deleteReminder(reminder);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
