// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../helpers/is_debugging.dart';
import '../type_defs.dart';

class LoginView extends HookWidget {
  final LoginCallback login;
  final VoidCallback navToRegisterView;

  const LoginView({
    Key? key,
    required this.login,
    required this.navToRegisterView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'hwangblood@gmail.com'.ifDebugging,
    );

    final passwordController = useTextEditingController(
      text: 'asdfghjkl'.ifDebugging,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Log in',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here...',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here...',
                ),
                obscureText: true,
                obscuringCharacter: '◉',
              ),
              TextButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  login(
                    email,
                    password,
                  );
                },
                child: const Text(
                  'Log in',
                ),
              ),
              TextButton(
                onPressed: navToRegisterView,
                child: const Text(
                  'Not registered yet? Register here!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
