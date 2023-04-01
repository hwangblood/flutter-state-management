import 'package:flutter/material.dart';
import 'package:notes_app/strings.dart' as strings;

import 'package:notes_app/dialogs/generic_dialog.dart' as generic_dialog;

typedef OnLoginTpped = void Function(String email, String password);

class LoginButton extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final OnLoginTpped onLoginTpped;

  const LoginButton({
    super.key,
    required this.passwordController,
    required this.emailController,
    required this.onLoginTpped,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;
        if (email.isEmpty || password.isEmpty) {
          generic_dialog.showGenericDialog<bool>(
            context: context,
            title: strings.emailOrPasswordEmptyDialogTitle,
            content: strings.emailOrPasswordEmptyDescription,
            optionsBuilder: () => {
              strings.ok: true,
            },
          );
        } else {
          onLoginTpped(email, password);
        }
      },
      child: const Text(strings.login),
    );
  }
}
