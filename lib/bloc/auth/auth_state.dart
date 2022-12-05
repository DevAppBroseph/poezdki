part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthOnboardingIncomplete extends AuthState {}

class ReferalSuccess extends AuthState {
  final String referalLink;

  ReferalSuccess({required this.referalLink});
}
