// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

import 'package:notes_app/models.dart';

@immutable
class AppState {
  /// isLoading state is for multiple kind of actions that need spend some time,
  ///  such as: login, fetch data, and more
  final bool isLoading;
  final LoginErrors? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? notes;

  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        notes = null;

  const AppState({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    required this.notes,
  });

  Map toMap() => {
        'isLoading': isLoading,
        'loginError': loginError,
        'loginHandle': loginHandle,
        'notes': notes,
      };
}
