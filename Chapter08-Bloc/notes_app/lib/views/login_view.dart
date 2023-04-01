import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes_app/views/email_text_field.dart';
import 'package:notes_app/views/login_button.dart';
import 'package:notes_app/views/password_text_field.dart';

class LoginView extends HookWidget {
  final OnLoginTpped onLoginTpped;
  const LoginView({
    super.key,
    required this.onLoginTpped,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(controller: emailController),
          PasswordTextField(controller: passwordController),
          LoginButton(
            passwordController: passwordController,
            emailController: emailController,
            onLoginTpped: onLoginTpped,
          ),
        ],
      ),
    );
  }
}
