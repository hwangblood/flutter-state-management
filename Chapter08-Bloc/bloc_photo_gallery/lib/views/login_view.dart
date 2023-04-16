import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:bloc_photo_gallery/bloc/app_bloc.dart';
import 'package:bloc_photo_gallery/bloc/app_event.dart';
import 'package:bloc_photo_gallery/extensions/if_debugging.dart';

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
        title: const Text('Log in'),
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
                  context.read<AppBloc>().add(
                        AppEventLogIn(
                          email: email,
                          password: password,
                        ),
                      );
                },
                child: const Text(
                  'Log in',
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<AppBloc>().add(
                        const AppEventNavToRegistration(),
                      );
                },
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
