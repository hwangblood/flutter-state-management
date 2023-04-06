part of 'auth_bloc.dart';

/// Action to interact with [AuthBloc]
@immutable
abstract class AuthAction {
  final String email;
  final String password;
  const AuthAction(this.email, this.password);
}

@immutable
class LoginAction extends AuthAction {
  const LoginAction(super.email, super.password);
}

@immutable
class RegisterAction extends AuthAction {
  const RegisterAction(super.email, super.password);
}
