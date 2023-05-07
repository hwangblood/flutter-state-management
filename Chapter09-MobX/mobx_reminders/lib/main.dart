import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:mobx_reminders/dialogs/auth_error_dialog.dart';
import 'package:mobx_reminders/loading/loading_overlay.dart';
import 'package:mobx_reminders/state/app_state.dart';
import 'package:mobx_reminders/views/login_view.dart';
import 'package:mobx_reminders/views/register_view.dart';
import 'package:mobx_reminders/views/reminders_view.dart';

import 'firebase_options.dart';

const String appName = 'MobX Reminders';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Provider(
      create: (_) => AppState()..initialize(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: ReactionBuilder(
        builder: (BuildContext context) {
          return autorun((_) {
            // handle loading state to show loading screen
            final isLoading = context.read<AppState>().isLoading;
            if (isLoading) {
              LoadingOverlay.instance().show(context);
            } else {
              LoadingOverlay.instance().hide();
            }

            // handle auth error state to show auth error dialog
            final authError = context.read<AppState>().authError;
            if (authError != null) {
              showAuthErrorDialog(context, authError: authError);
            }
          });
        },
        child: Observer(
          name: 'CurrentScreen',
          builder: (BuildContext context) {
            final currentScreen = context.watch<AppState>().currentScreen;
            switch (currentScreen) {
              case AppScreen.login:
                return const LoginView();
              case AppScreen.register:
                return const RegisterView();
              case AppScreen.reminders:
                return const RemindersView();
            }
          },
        ),
      ),
    );
  }
}
