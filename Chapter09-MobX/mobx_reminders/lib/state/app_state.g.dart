// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on AppStateBase, Store {
  Computed<ObservableList<Reminder>>? _$sortedRemindersComputed;

  @override
  ObservableList<Reminder> get sortedReminders => (_$sortedRemindersComputed ??=
          Computed<ObservableList<Reminder>>(() => super.sortedReminders,
              name: 'AppStateBase.sortedReminders'))
      .value;

  late final _$currentScreenAtom =
      Atom(name: 'AppStateBase.currentScreen', context: context);

  @override
  AppScreen get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(AppScreen value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AppStateBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: 'AppStateBase.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$authErrorAtom =
      Atom(name: 'AppStateBase.authError', context: context);

  @override
  AuthError? get authError {
    _$authErrorAtom.reportRead();
    return super.authError;
  }

  @override
  set authError(AuthError? value) {
    _$authErrorAtom.reportWrite(value, super.authError, () {
      super.authError = value;
    });
  }

  late final _$remindersAtom =
      Atom(name: 'AppStateBase.reminders', context: context);

  @override
  ObservableList<Reminder> get reminders {
    _$remindersAtom.reportRead();
    return super.reminders;
  }

  @override
  set reminders(ObservableList<Reminder> value) {
    _$remindersAtom.reportWrite(value, super.reminders, () {
      super.reminders = value;
    });
  }

  late final _$deleteReminderAsyncAction =
      AsyncAction('AppStateBase.deleteReminder', context: context);

  @override
  Future<bool> deleteReminder(Reminder reminder) {
    return _$deleteReminderAsyncAction
        .run(() => super.deleteReminder(reminder));
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('AppStateBase.deleteAccount', context: context);

  @override
  Future<bool> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$logoutAsyncAction =
      AsyncAction('AppStateBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$createReminderAsyncAction =
      AsyncAction('AppStateBase.createReminder', context: context);

  @override
  Future<bool> createReminder(String text) {
    return _$createReminderAsyncAction.run(() => super.createReminder(text));
  }

  late final _$modifyAsyncAction =
      AsyncAction('AppStateBase.modify', context: context);

  @override
  Future<bool> modify(Reminder reminder, {required bool isDone}) {
    return _$modifyAsyncAction
        .run(() => super.modify(reminder, isDone: isDone));
  }

  late final _$initializeAsyncAction =
      AsyncAction('AppStateBase.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$_loadDataAsyncAction =
      AsyncAction('AppStateBase._loadData', context: context);

  @override
  Future<bool> _loadData() {
    return _$_loadDataAsyncAction.run(() => super._loadData());
  }

  late final _$_loginOrRegisterAsyncAction =
      AsyncAction('AppStateBase._loginOrRegister', context: context);

  @override
  Future<bool> _loginOrRegister(
      {required LoginOrRegisterFunction fn,
      required String email,
      required String password}) {
    return _$_loginOrRegisterAsyncAction.run(
        () => super._loginOrRegister(fn: fn, email: email, password: password));
  }

  late final _$AppStateBaseActionController =
      ActionController(name: 'AppStateBase', context: context);

  @override
  void navigateTo(AppScreen screen) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.navigateTo');
    try {
      return super.navigateTo(screen);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> register({required String email, required String password}) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.register');
    try {
      return super.register(email: email, password: password);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> login({required String email, required String password}) {
    final _$actionInfo =
        _$AppStateBaseActionController.startAction(name: 'AppStateBase.login');
    try {
      return super.login(email: email, password: password);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
isLoading: ${isLoading},
currentUser: ${currentUser},
authError: ${authError},
reminders: ${reminders},
sortedReminders: ${sortedReminders}
    ''';
  }
}
