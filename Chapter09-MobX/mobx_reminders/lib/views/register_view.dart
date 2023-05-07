import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:mobx_reminders/extensions/if_debugging.dart';
import 'package:mobx_reminders/state/app_state.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});

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
        title: const Text('Register'),
      ),
      body: Column(
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
              context.read<AppState>().register(
                    email: email,
                    password: password,
                  );
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              context.read<AppState>().navigateToLogin();
            },
            child: const Text('Already registered? Log in here!'),
          ),
        ],
      ),
    );
  }
}
