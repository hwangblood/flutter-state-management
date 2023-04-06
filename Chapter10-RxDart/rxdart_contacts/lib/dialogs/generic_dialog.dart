import 'package:flutter/material.dart';

/// A Builder Function that generating actions for an [AlertDialog], the key of
/// map will be displayed as title in a [TextButton], and the value typed with
/// T? will be returned from [AlertDialog].
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

/// Show a generic dialog with title and content, and generating actions by a
/// [DialogOptionBuilder].
Future<T?> showGenericDialog<T>(
  BuildContext context, {
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
