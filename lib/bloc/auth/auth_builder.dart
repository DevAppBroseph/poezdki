import 'package:app_poezdka/src/app_screens.dart';
import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/src/onboarding/on_board.dart';
import 'package:flutter/material.dart';

import '../../export/blocs.dart';

class AppInitBuilder extends StatelessWidget {
  const AppInitBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthInitial) {
        return const Scaffold(body: CircularProgressIndicator());
      } else if (state is AuthLoading) {
        return const Scaffold(body:  CircularProgressIndicator());
      } else if (state is AuthOnboardingIncomplete) {
        return const IntroScreenDefault();
      } else if (state is AuthAuthenticated) {
        return const AppScreens();
      } else if (state is AuthUnauthenticated) {
        return const SignInScreen();
      }

      // Default screen
      return const Scaffold(body: CircularProgressIndicator());
    });
  }
}
