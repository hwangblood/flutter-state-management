import 'package:mobx/mobx.dart';

import 'package:mobx_reminders/errors/auth_error.dart';
import 'package:mobx_reminders/provider/auth_provider.dart';
import 'package:mobx_reminders/provider/reminders_provider.dart';
import 'package:mobx_reminders/state/reminder.dart';

part 'app_state.g.dart';

class AppState = AppStateBase with _$AppState;

abstract class AppStateBase with Store {
  final AuthProvider authProvider;
  final RemindersProvider remindersProvider;

  AppStateBase({
    required this.authProvider,
    required this.remindersProvider,
  });

  @observable
  AppScreen currentScreen = AppScreen.login;

  @observable
  bool isLoading = false;

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

  @action
  void _navigateTo(AppScreen screen) {
    // observable field can only be change in function with action annotation
    currentScreen = screen;
  }

  @action
  void navigateToLogin() {
    _navigateTo(AppScreen.login);
  }

  @action
  void navigateToRegister() {
    _navigateTo(AppScreen.register);
  }

  @action
  void navigateToReminders() {
    _navigateTo(AppScreen.reminders);
  }

  /// Delete a reminder from Cloud Firestore and app's state
  @action
  Future<bool> deleteReminder(
    Reminder reminder,
  ) async {
    isLoading = true;
    final String? userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    try {
      // delete from Cloud Firestore
      await remindersProvider.deleteReminderWithId(
        reminder.id,
        userId: userId,
      );
      // delete locally as well
      reminders.removeWhere(
        (element) => element.id == reminder.id,
      );
      // delete action successfully
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  /// Delete current user account, which also deletes all reminders of the user
  @action
  Future<bool> deleteAccount() async {
    isLoading = true;
    final String? userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    try {
      // delete all reminder documents from firestore
      await remindersProvider.deleteAllReminders(
        userId: userId,
      );
      // remove all reminders locally when we log out
      reminders.clear();
      // delete accounts and sign out
      await authProvider.deleteAccountAndSignOut();
      // update app state, navigate to login
      navigateToLogin();
      return true;
    } on AuthError catch (e) {
      authError = e;
      return false;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  /// Logout the current user
  @action
  Future<void> logout() async {
    isLoading = true;

    // sign out the current user
    await authProvider.signOut();

    // update app state
    reminders.clear();
    isLoading = false;
    navigateToLogin();
  }

  /// Create a reminder to Cloud Firestore and app's state
  @action
  Future<bool> createReminder(String text) async {
    isLoading = true;
    final String? userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    try {
      final createAt = DateTime.now();
      final reminderId = await remindersProvider.createReminder(
        userId: userId,
        text: text,
        creationDate: createAt,
      );
      // create locally reminder
      final reminder = Reminder(
        id: reminderId,
        createAt: createAt,
        text: text,
        isDone: false,
      );
      // update app state
      reminders.add(reminder);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  /// Modify a reminder is done or not
  ///
  /// And the isLoading state is not needed for this case
  @action
  Future<bool> modifyReminder({
    required ReminderId reminderId,
    required bool isDone,
  }) async {
    final String? userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    // update the remote reminder
    await remindersProvider.modify(
      reminderId: reminderId,
      isDone: isDone,
      userId: userId,
    );

    // update the local reminder
    reminders
        .firstWhere(
          (element) => element.id == reminderId,
        )
        .isDone = isDone;

    return true;
  }

  /// Initialize app's state, only be called when launch the app
  @action
  Future<void> initialize() async {
    isLoading = true;
    final String? userId = authProvider.userId;

    if (userId == null) {
      navigateToLogin();
      isLoading = false;
      return;
    }

    // load the reminders from Cloud Firestore
    // ignore: unused_local_variable
    final dataResult = await _loadReminders();
    // TODO: check loaded reminders is successful or not, and do some special operation for different result
    // if (loadResult) {
    // loading successful, navgate user to reminders screen
    // } else {
    // loading failed, should show error message to user, or more
    // }

    isLoading = false;
    navigateToReminders();
  }

  /// Load the reminders from Cloud Firestore
  @action
  Future<bool> _loadReminders() async {
    final String? userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    try {
      final data = await remindersProvider.loadReminders(
        userId: userId,
      );

      // update the app state
      reminders = ObservableList.of(data);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  /// Login or register user
  @action
  Future<bool> _loginOrRegister({
    required LoginOrRegisterFunction fn,
    required String email,
    required String password,
  }) async {
    authError = null;
    isLoading = true;

    try {
      final succeeded = await fn(
        email: email,
        password: password,
      );

      if (succeeded) {
        await _loadReminders();
      }
      return succeeded;
    } on AuthError catch (e) {
      authError = e;
      return false;
    } finally {
      isLoading = false;
      if (authProvider.userId != null) {
        navigateToReminders();
      }
    }
  }

  /// Create a user account with email and pasword by [FirebaseAuth]
  @action
  Future<bool> register({
    required String email,
    required String password,
  }) =>
      _loginOrRegister(
        fn: authProvider.register,
        email: email,
        password: password,
      );

  /// Log a user account in with email and pasword by [FirebaseAuth]
  @action
  Future<bool> login({
    required String email,
    required String password,
  }) =>
      _loginOrRegister(
        fn: authProvider.login,
        email: email,
        password: password,
      );
}

typedef LoginOrRegisterFunction = Future<bool> Function({
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
