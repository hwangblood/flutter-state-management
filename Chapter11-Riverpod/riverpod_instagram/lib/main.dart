import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:riverpod_instagram/state/auth/providers/is_logged_in_provider.dart';
import 'package:riverpod_instagram/state/prividers/is_loading_provider.dart';
import 'package:riverpod_instagram/views/components/loading/loading_overlay.dart';
import 'package:riverpod_instagram/views/login/login_view.dart';

import 'firebase_options.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Instagram',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          // take care of displaying the loading overlay
          // listen won't rebuild widget, it just get the ability to do sth
          ref.listen(
            isLoadingProvider,
            (previous, next) {
              // next is the new state of the provider
              if (next) {
                LoadingOverlay.instance().show(context);
              } else {
                LoadingOverlay.instance().hide();
              }
            },
          );

          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

/// for when you are already logged in
class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Instagram'),
      ),
      body: Center(
        child: Consumer(
          builder: (_, ref, child) {
            return ElevatedButton(
              onPressed: () {
                ref.read(authStateProvider.notifier).logout();
              },
              child: const Text('Logout'),
            );
          },
        ),
      ),
    );
  }
}
