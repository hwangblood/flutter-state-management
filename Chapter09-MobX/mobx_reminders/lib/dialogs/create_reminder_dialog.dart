import 'package:flutter/material.dart';

import 'show_text_field_dialog.dart';

Future<String?> showCreateReminderDialog(BuildContext context) =>
    showTextFieldDialog(
      context,
      title: 'Create Reminder',
      hintText: 'Enter your reminder here...',
      optionsBuilder: () => {
        TextFieldDialogButtonType.cacel: 'Cancel',
        TextFieldDialogButtonType.comfirm: 'Save',
      },
    );
