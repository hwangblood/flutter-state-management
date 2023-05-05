import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_reminders/state/auth_error.dart';
import 'package:mobx_reminders/state/reminder.dart';

part 'app_state.g.dart';

class AppState = AppStateBase with _$AppState;

abstract class AppStateBase with Store {
  @observable
  AppScreen currentScreen = AppScreen.login;

  @observable
  bool isLoading = false;

  @observable
  User? currentUser;

  @observable
  AuthError? authError;

  /// Observe all reminders, and it default be empty [ObservableList]
  @observable
  ObservableList<Reminder> reminders = ObservableList<Reminder>();

  /// Sorted reminder list, it is also [ObservableList]
  @computed
  ObservableList<Reminder> get sortedReminders => ObservableList.of(
        reminders.sorted(),
      );
}

abstract class _DocumentKeys {
  static const String text = 'text';
  static const String createAt = 'create_at';
  static const String isDone = 'is_done';
}

typedef LoginOrRegisterFunction = Future<UserCredential> Function({
  required String email,
  required String password,
});

extension ToInt on bool {
  /// Convert false to 0, true to 1
  int toInteger() => this ? 1 : 0;
}

extension Sorted on Iterable<Reminder> {
  /// Sort Reminders by isDone and createAt
  ///
  /// Iterable.sort() example:
  /// ```dart
  /// final numbers = <String>['two', 'three', 'four'];
  /// Sort from shortest to longest.
  /// numbers.sort((a, b) => a.length.compareTo(b.length));
  /// print(numbers); // [two, four, three]
  /// ```
  Iterable<Reminder> sorted() => [...this]..sort((a, b) {
      final isDone = a.isDone.toInteger().compareTo(b.isDone.toInteger());
      if (isDone != 0) {
        return isDone;
      }
      return a.createAt.compareTo(b.createAt);
    });
}

enum AppScreen { login, register, reminders }
