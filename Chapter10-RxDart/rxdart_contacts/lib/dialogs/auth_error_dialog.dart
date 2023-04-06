import 'package:flutter/material.dart';

import '../blocs/auth_bloc/auth_error.dart';
import 'generic_dialog.dart';

Future<void> showAuthErrorDialog(
  BuildContext context, {
  required AuthError authError,
}) {
  return showGenericDialog(
    context,
    title: authError.title,
    content: authError.content,
    optionsBuilder: () => {'OK': true},
  );
}
