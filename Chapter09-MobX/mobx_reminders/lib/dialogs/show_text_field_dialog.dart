import 'package:flutter/material.dart';

enum TextFieldDialogButtonType { cacel, comfirm }

/// Action buttons For a dialog with a [TextFormField]
typedef TextFieldDialogOptionsBuilder = Map<TextFieldDialogButtonType, String>
    Function();

Future<String?> showTextFieldDialog(
  BuildContext context, {
  required String title,
  required String? hintText,
  required TextFieldDialogOptionsBuilder optionsBuilder,
}) async {
  final controller = TextEditingController();
  final options = optionsBuilder();
  return showDialog<String?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextFormField(
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
        actions: options.entries.map((option) {
          return TextButton(
            onPressed: () {
              switch (option.key) {
                case TextFieldDialogButtonType.cacel:
                  Navigator.of(context).pop();
                  break;
                case TextFieldDialogButtonType.comfirm:
                  Navigator.of(context).pop(controller.text);
                  break;
              }
            },
            child: Text(option.value),
          );
        }).toList(),
      );
    },
  );
}
