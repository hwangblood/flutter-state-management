import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:mobx_reminders/extensions/if_debugging.dart';
import 'package:mobx_reminders/state/app_state.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

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
        title: const Text('Login'),
      ),
      body: Padding(
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
                context
                    .read<AppState>()
                    .login(email: email, password: password);
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                context.read<AppState>().navigateToRegister();
              },
              child: const Text('Not registered yet? Register here!'),
            ),
          ],
        ),
      ),
    );
  }
}
