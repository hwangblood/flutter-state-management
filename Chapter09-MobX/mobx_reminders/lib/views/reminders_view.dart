import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mobx_reminders/dialogs/show_text_field_dialog.dart';
import 'package:mobx_reminders/state/app_state.dart';
import 'package:mobx_reminders/widgets/main_popup_menu_button.dart';
import 'package:mobx_reminders/widgets/reminder_list_view.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobX Reminders'),
        actions: [
          IconButton(
            onPressed: () async {
              final appState = context.read<AppState>();
              final reminderText = await showTextFieldDialog(
                context,
                title: 'What do you want me to remind you about?',
                hintText: 'Enter your reminder text here...',
                optionsBuilder: () => {
                  TextFieldDialogButtonType.cacel: 'Cancel',
                  TextFieldDialogButtonType.comfirm: 'Save',
                },
              );
              if (reminderText == null) {
                return;
              }
              appState.createReminder(reminderText);
            },
            icon: const Icon(Icons.add),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: const ReminderListView(),
    );
  }
}
