import 'package:app_poezdka/model/server_responce.dart';
import 'package:app_poezdka/service/server/auth_service.dart';

import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../export/services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorage userRepository;
  final HiveBoxService appRepository;
  final authService = AuthService();
  final dialog = ErrorDialogs();
  AuthBloc({required this.userRepository, required this.appRepository})
      : super(AuthUnauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<AppInit>(_initApp);
    on<SignUp>(_onSignUp);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<OnBoardComplete>(_onOnBoardComplete);
    on<AuthError>(_onAuthError);
    ////////// Dev ////////
    on<OnDevLogIn>(_devLogIn);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final firstLaunch = appRepository.firstLaunch();

    if (firstLaunch == null || firstLaunch == true) {
      await userRepository.deleteAll();
      emit(AuthOnboardingIncomplete());
    } else {
      add(AppInit());
    }
  }

  void _initApp(AppInit event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final hasToken = await userRepository.hasToken();
    print(await userRepository.getToken());

    hasToken == true ? emit(AuthSuccess()) : emit(AuthUnauthenticated());
  }

  void _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final ResponceAuth? data = await authService.signUp(
        login: event.login,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        gender: event.gender,
        birth: event.birth);

    if (data != null) {
      await userRepository.persistEmailAndToken(
          event.login, data.token, data.id);
      add(AppInit());
      Navigator.pop(event.context);
      Navigator.pop(event.context);
      Navigator.pop(event.context);
    } else {
      add(AuthError("Ошибка регистрации."));
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    final authService = AuthService();
    emit(AuthLoading());
    final ResponceAuth? responceSignIn =
        await authService.signIn(login: event.email, password: event.password);

    if (responceSignIn != null) {
      await userRepository.persistEmailAndToken(
          event.email, responceSignIn.token, responceSignIn.id);
      add(AppStarted());
      Navigator.pop(event.context);
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await userRepository.deleteUserData();
    add(AppInit());
  }

  void _onOnBoardComplete(
      OnBoardComplete event, Emitter<AuthState> emit) async {
    appRepository.setFirstLaunch(false);
    add(AppInit());
  }

  void _onAuthError(AuthError event, Emitter<AuthState> emit) async {}

  void _devLogIn(OnDevLogIn event, Emitter<AuthState> emit) async {
    await userRepository.persistEmailAndToken("email", "token", 1);
    add(AppInit());
  }
}
