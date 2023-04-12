import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../helpers/is_debugging.dart';
import '../type_defs.dart';

class RegisterView extends HookWidget {
  final RegisterCallback register;
  final VoidCallback navToLoginView;

  const RegisterView({
    Key? key,
    required this.register,
    required this.navToLoginView,
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
          'Register',
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
                  register(
                    email,
                    password,
                  );
                },
                child: const Text(
                  'Register',
                ),
              ),
              TextButton(
                onPressed: navToLoginView,
                child: const Text(
                  'Already registered? Log in here!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
