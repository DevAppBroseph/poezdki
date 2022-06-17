part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthOnboardingIncomplete extends AuthState {}
