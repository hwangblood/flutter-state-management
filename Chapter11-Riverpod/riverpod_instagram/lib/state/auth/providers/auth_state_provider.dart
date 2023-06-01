import 'package:riverpod/riverpod.dart';

import 'package:riverpod_instagram/state/auth/models/auth_state.dart';
import 'package:riverpod_instagram/state/auth/notifiers/auth_state_notifier.dart';

final authStateProvider = NotifierProvider<AuthStateNotifier, AuthState>(
  AuthStateNotifier.new,
);
