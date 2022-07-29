import 'package:app_poezdka/src/app_screens.dart';
import 'package:app_poezdka/src/onboarding/on_board.dart';
import 'package:app_poezdka/widget/src_template/search.dart';
import 'package:flutter/material.dart';

import '../../export/blocs.dart';

class AppInitBuilder extends StatelessWidget {
  const AppInitBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthInitial) {
        return const Scaffold(body: CircularProgressIndicator());
      }
      if (state is AuthLoading) {
        return const Scaffold(body: CircularProgressIndicator());
      }
      if (state is AuthLoading) {
        return const Scaffold(body: CircularProgressIndicator());
      }
      if (state is AuthOnboardingIncomplete) {
        return const IntroScreenDefault();
      }
      if (state is AuthSuccess) {
        return const AppScreens();
      }
      if (state is AuthUnauthenticated) {
        return const SearchRides(isAuthorized: false,);
      }

      // Default screen
      return const Scaffold(body: CircularProgressIndicator());
    });
  }
}
