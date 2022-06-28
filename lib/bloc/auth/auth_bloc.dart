import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/service/auth_service.dart';
import 'package:app_poezdka/service/box_service.dart';
import 'package:app_poezdka/service/secure_storage.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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

    if (!hasToken) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated());
    }
  }

  void _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final String? token = await authService.signUp(
        login: event.login,
        password: event.password,
        firstName: event.userModel.firstName,
        lastName: event.userModel.lastName,
        gender: event.userModel.gender,
        birth: event.userModel.birth);

    if (token != null) {
      await userRepository.persistEmailAndToken(event.login, token);
      add(AppInit());
    } else {
      add(AuthError("Ошибка регистрации."));
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await userRepository.persistEmailAndToken(event.email, event.token);

    add(AppInit());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await userRepository.deleteToken();
    add(AppInit());
  }

  void _onOnBoardComplete(
      OnBoardComplete event, Emitter<AuthState> emit) async {
    appRepository.setFirstLaunch(false);
    add(AppInit());
  }

  void _onAuthError(AuthError event, Emitter<AuthState> emit) async {}

  void _devLogIn(OnDevLogIn event, Emitter<AuthState> emit) async {
    await userRepository.persistEmailAndToken("email", "token");
    add(AppInit());
  }
}
