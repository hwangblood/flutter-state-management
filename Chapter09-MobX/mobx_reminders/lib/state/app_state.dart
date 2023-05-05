import 'package:cloud_firestore/cloud_firestore.dart';
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

  @action
  void navigateTo(AppScreen screen) {
    // observable field can only be change in function with action annotation
    currentScreen = screen;
  }

  /// Delete a reminder from Cloud Firestore and local state
  @action
  Future<bool> deleteReminder(Reminder reminder) async {
    isLoading = true;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    // if user not logged in, can't delete any reminders
    if (user == null) {
      isLoading = false;
      return false;
    }

    final String userId = user.uid;
    final colletion = await FirebaseFirestore.instance.collection(userId).get();

    try {
      // delete from Cloud Firestore
      final storedReminder = colletion.docs.firstWhere(
        (doc) => doc.id == reminder.id,
      );
      await storedReminder.reference.delete();
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
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      isLoading = false;
      return false;
    }

    final String userId = user.uid;
    try {
      final firestore = FirebaseFirestore.instance;
      final operation = firestore.batch();
      final collection = await firestore.collection(userId).get();
      for (final document in collection.docs) {
        operation.delete(document.reference);
      }
      // delete all reminders for current user on Firebase
      await operation.commit();
      // delete the current user
      await user.delete();
      // log the current user out
      await auth.signOut();
      // update app state
      currentScreen = AppScreen.login;
      reminders.clear();
      return true;
    } on FirebaseAuthException catch (e) {
      authError = AuthError.from(e);
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
    try {
      await FirebaseAuth.instance.signOut();
      // update app state
      currentScreen = AppScreen.login;
      reminders.clear();
    } on FirebaseAuthException catch (e) {
      authError = AuthError.from(e);
    } catch (_) {
      // we are ignoring the error here
    } finally {
      isLoading = false;
    }
  }
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
