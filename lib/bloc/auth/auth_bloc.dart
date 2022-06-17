import 'package:app_poezdka/service/box_service.dart';
import 'package:app_poezdka/service/secure_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorage userRepository;
  final HiveBoxService appRepository;
  AuthBloc({required this.userRepository, required this.appRepository})
      : super(AuthUnauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<AppInit>(_initStartup);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<OnBoardComplete>(_onOnBoardComplete);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final firstLaunch = appRepository.firstLaunch();
    

    if (firstLaunch ?? true) {
      await userRepository.deleteAll();
      emit(AuthOnboardingIncomplete());
    }
    add(AppInit());
  }

  void _initStartup(AppInit event, Emitter<AuthState> emit) async {
    final hasToken = await userRepository.hasToken();

    if (!hasToken) {
      emit(AuthUnauthenticated());
    }

    emit(AuthAuthenticated());
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await userRepository.persistEmailAndToken(event.email, event.token);

    add(AppInit());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await userRepository.deleteToken();
  }

  void _onOnBoardComplete(
      OnBoardComplete event, Emitter<AuthState> emit) async {
    add(AppInit());
  }
}
