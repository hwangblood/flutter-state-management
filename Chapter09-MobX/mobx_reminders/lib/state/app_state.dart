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

  /// Delete a reminder from Cloud Firestore and app's state
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
      currentUser = null;
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
      currentUser = null;
      authError = AuthError.from(e);
    } catch (_) {
      // we are ignoring the error here
    } finally {
      isLoading = false;
    }
  }

  /// Create a reminder to Cloud Firestore and app's state
  @action
  Future<bool> createReminder(String text) async {
    isLoading = true;
    final userId = currentUser?.uid;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    try {
      final createAt = DateTime.now();
      // create the firestore reminder
      final firestoreReminder =
          await FirebaseFirestore.instance.collection(userId).add({
        _DocumentKeys.text: text,
        _DocumentKeys.createAt: createAt,
        _DocumentKeys.isDone: false,
      });
      // create locally reminder
      final reminder = Reminder(
        id: firestoreReminder.id,
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
  Future<bool> modify(
    Reminder reminder, {
    required bool isDone,
  }) async {
    final userId = currentUser?.uid;
    if (userId == null) {
      return false;
    }

    try {
      // update the remote reminder
      final colletion =
          await FirebaseFirestore.instance.collection(userId).get();
      final storedReminder = colletion.docs
          .firstWhere(
            (element) => element.id == reminder.id,
          )
          .reference;
      await storedReminder.update({
        _DocumentKeys.isDone: isDone,
      });

      // update the local reminder
      reminders
          .firstWhere(
            (element) => element.id == reminder.id,
          )
          .isDone = isDone;

      // update app state
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Initialize app's state, only be called when launch the app
  @action
  Future<void> initialize() async {
    isLoading = true;
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      currentScreen = AppScreen.login;
    }
    // load the reminders from Cloud Firestore
    // ignore: unused_local_variable
    final loadResult = await _loadData();
    currentScreen = AppScreen.reminders;
    // TODO: check loading reminders is successful or not, and do some special operation for different result
    // if (loadResult) {
    // loading successful, navgate user to reminders screen
    // } else {
    // loading failed, should show error message to user, or more
    // }

    // close loading state
    isLoading = false;
  }

  /// Load the reminders from Cloud Firestore
  @action
  Future<bool> _loadData() async {
    final userId = currentUser?.uid;
    if (userId == null) {
      return false;
    }

    try {
      final collection =
          await FirebaseFirestore.instance.collection(userId).get();
      final storedReminders = collection.docs.map(
        (doc) => Reminder(
          id: doc.id,
          createAt: DateTime.parse(doc[_DocumentKeys.createAt] as String),
          text: doc[_DocumentKeys.text] as String,
          isDone: doc[_DocumentKeys.isDone] as bool,
        ),
      );
      // update the app state
      reminders = ObservableList.of(storedReminders);
      return true;
    } catch (_) {
      return false;
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
      await fn(email: email, password: password);
      currentUser = FirebaseAuth.instance.currentUser;
      await _loadData();
      return true;
    } on FirebaseAuthException catch (e) {
      authError = null;
      authError = AuthError.from(e);
      return false;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
      if (currentUser != null) {
        currentScreen = AppScreen.reminders;
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
        fn: FirebaseAuth.instance.createUserWithEmailAndPassword,
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
        fn: FirebaseAuth.instance.signInWithEmailAndPassword,
        email: email,
        password: password,
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
