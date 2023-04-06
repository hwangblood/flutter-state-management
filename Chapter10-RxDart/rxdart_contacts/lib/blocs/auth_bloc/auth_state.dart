part of 'auth_bloc.dart';

/// State hold by [AuthBloc]
@immutable
abstract class AuthState {
  const AuthState();
}

@immutable
class AuthStateLoggedIn implements AuthState {
  const AuthStateLoggedIn();
}

@immutable
class AuthStateLoggedOut implements AuthState {
  const AuthStateLoggedOut();
}
