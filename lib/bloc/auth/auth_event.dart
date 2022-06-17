part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class AppInit extends AuthEvent {}

class SignUp extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String email;
  final String token;

  LoggedIn(this.email, this.token);
}

class LoggedOut extends AuthEvent {}

class OnBoardComplete extends AuthEvent {}
