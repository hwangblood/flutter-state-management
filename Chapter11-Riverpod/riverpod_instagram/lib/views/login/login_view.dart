import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:riverpod_instagram/views/constants/app_colors.dart';
import 'package:riverpod_instagram/views/constants/strings.dart';
import 'package:riverpod_instagram/views/login/divider_with_margin.dart';
import 'package:riverpod_instagram/views/login/facebook_buttton.dart';
import 'package:riverpod_instagram/views/login/google_button.dart';
import 'package:riverpod_instagram/views/login/login_view_signup_link.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Strings.appName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DividerWithMargin(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: ref
                    .read(authStateNotifierProvider.notifier)
                    .loginWithGoogle,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                child: const GoogleButton(),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: ref
                    .read(authStateNotifierProvider.notifier)
                    .loginWithFacebook,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                child: const FacebookButton(),
              ),
              const DividerWithMargin(),
              const LoginViewSignupLink(),
            ],
          ),
        ),
      ),
    );
  }
}
