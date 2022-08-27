part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class AppInit extends AuthEvent {}

class SignUp extends AuthEvent {
  final BuildContext context;
  final String login;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;
  final int birth;

  SignUp({
    required this.context,
    required this.login,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birth,
  });
}

class LoggedIn extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  LoggedIn(this.context, this.email, this.password);
}

class LoggedOut extends AuthEvent {}

class OnBoardComplete extends AuthEvent {}

class SignInWithGoogle extends AuthEvent {
  final GoogleSignInAccount account;
  final BuildContext context;

  SignInWithGoogle(this.account, this.context);
}

class SignInWithVk extends AuthEvent {
  final UserModel account;
  final BuildContext context;

  SignInWithVk(this.account, this.context);
}

class DeleteProfile extends AuthEvent {}

class AuthError extends AuthEvent {
  final String? error;

  AuthError(this.error);
}

class OnDevLogIn extends AuthEvent {}
