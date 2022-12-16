import 'package:app_poezdka/src/app_screens.dart';
import 'package:app_poezdka/src/auth/signup.dart';
import 'package:app_poezdka/src/onboarding/on_board.dart';
import 'package:app_poezdka/src/trips/search_trips.dart';
import 'package:flutter/material.dart';

import '../../export/blocs.dart';

class AppInitBuilder extends StatelessWidget {
  String? referal;
  AppInitBuilder({Key? key, this.referal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<ChatBloc>(context);
    // BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      print('object auth_builder state $state');
      if (referal == null) {
        if (state is AuthOnboardingIncomplete) {
          return const IntroScreenDefault();
        }
        if (state is AuthSuccess) {
          return const AppScreens();
        }
        if (state is AuthUnauthenticated) {
          return const SearchRides(
            isAuthorized: false,
          );
        }
        return Scaffold(body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text(state.toString())
          ],
        ));
        // if (state is ReferalSuccess) {
        //   return Scaffold(
        //     body: Center(
        //       child: Text(state.referalLink),
        //     ),
        //   );
        // }
      } else {
        return SignUpScreen(referal: referal);
      }
    });
  }
}
