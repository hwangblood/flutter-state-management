import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart/rxdart.dart';

import '../base_bloc.dart';
import 'auth_error.dart';

part 'auth_action.dart';
part 'auth_state.dart';

@immutable
class AuthBloc implements BaseBloc {
  // read-only properties
  final Stream<AuthState> authState;
  final Stream<AuthError?> authError;
  final Stream<bool> isLoading;

  /// real-time userId for account
  final Stream<String?> userId;

  // write-only properties
  final Sink<LoginAction> login;
  final Sink<RegisterAction> register;

  /// Logout operation requires nothing as payload, so the [Sink] handle void
  /// values
  ///
  /// use it, such as:
  /// ```dart
  /// authBloc.logout.add({});
  /// ```
  final Sink<void> logout;

  @override
  void dispose() {
    login.close();
    register.close();
    logout.close();
  }

  const AuthBloc._({
    required this.authState,
    required this.authError,
    required this.isLoading,
    required this.userId,
    required this.login,
    required this.register,
    required this.logout,
  });

  factory AuthBloc() {
    final loadingSubject = BehaviorSubject<bool>();

    // calculate auth state
    final Stream<AuthState> authStateStream =
        FirebaseAuth.instance.authStateChanges().map(
              (user) => user != null
                  ? const AuthStateLoggedIn()
                  : const AuthStateLoggedOut(),
            );

    // get the user id
    final Stream<String?> userIdStream = FirebaseAuth.instance
        .authStateChanges() // only changes happen will receive a new value
        .map((user) => user?.uid)
        // Once you logged into app and start in the future, the [userId] of our
        // [AuthBloc] wil be null, so we need to using [startWith] to fetch the
        // current [userId] of our app from Firebase backend
        .startWith(FirebaseAuth.instance.currentUser?.uid);

    // login and error handling
    final loginSubject = BehaviorSubject<LoginAction>();
    final Stream<AuthError?> loginErrorStream = loginSubject.auth(
      (action) => FirebaseAuth.instance.signInWithEmailAndPassword(
        email: action.email,
        password: action.password,
      ),
      loadingSubject,
    );

    // register and error handling
    final registerSubject = BehaviorSubject<RegisterAction>();
    final Stream<AuthError?> rigisterErrorStream = registerSubject.auth(
      (action) => FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: action.email,
        password: action.password,
      ),
      loadingSubject,
    );

    // logout and error handling
    final logoutSubject = BehaviorSubject<void>();
    final logoutErrorStream = logoutSubject.auth(
      (_) => FirebaseAuth.instance.signOut(),
      loadingSubject,
    );

    // auth error = (login error + register error + logout error)
    // Merge login, register and logout error streams into one stream
    final Stream<AuthError?> authErrorStream = Rx.merge([
      loginErrorStream,
      rigisterErrorStream,
      logoutErrorStream,
    ]);

    return AuthBloc._(
      authState: authStateStream,
      authError: authErrorStream,
      isLoading: loadingSubject.stream,
      userId: userIdStream,
      login: loginSubject.sink,
      register: registerSubject.sink,
      logout: logoutSubject.sink,
    );
  }
}

/// T will be LoginAction and RegisterAction for login and register operation,
/// and void for logout operation
typedef AuthRunner<T> = Future Function(T action);

extension Auth<T> on Stream<T> {
  /// Generic auth rx-operator for login, register, logout operation, all of
  /// these operations have the same logic
  ///
  /// Logic: When start auth, firstly set loading state to `true`, and then run
  /// auth operation, after finish auth operation, set loading state to `false`
  Stream<AuthError?> auth(
    AuthRunner runner,
    BehaviorSubject<bool> loadingSubject,
  ) {
    return setLoadingTo(true, sink: loadingSubject.sink)
        .asyncMap<AuthError?>((action) async {
      try {
        await runner(action);
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (e) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, sink: loadingSubject.sink);
  }
}

extension Loading<E> on Stream<E> {
  /// When Stream update every time, add [isLoading] to another `Stream<bool>`
  ///
  /// Example:
  ///
  /// ```dart
  /// final stream = Stream.periodic(const Duration(seconds: 1), (count) => count);
  /// final loadingController = StreamController<bool>();
  /// final result= stream.setLoadingTo(true, sink: loadingController.sink);
  /// ```
  Stream<E> setLoadingTo(
    bool isLoading, {
    required Sink<bool> sink,
  }) =>
      doOnEach((_) => sink.add(isLoading));
}
