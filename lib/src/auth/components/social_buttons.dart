import 'dart:io';

import 'package:app_poezdka/bloc/auth/auth_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/src/auth/signup_phone.dart';
import 'package:app_poezdka/widget/button/full_width_leveated_button_child.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthButtons extends StatelessWidget {
  SocialAuthButtons({Key? key}) : super(key: key);

  final vk = VKLogin();

  @override
  Widget build(BuildContext context) {
    const path = "assets/img";
    return Column(
      children: [
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("$path/vk.png"),
              const Text(
                "   Вконтакте",
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
          onPressed: () {
            _signInWithVk(context);
          },
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: Image.asset("$path/google.png"),
          onPressed: () {
            _signWithGoogle(context);
          },
        ),
        // if (Platform.isIOS)
        //   FullWidthElevButtonChild(
        //     margin: const EdgeInsets.symmetric(horizontal: 10),
        //     color: kPrimaryWhite,
        //     child: Image.asset("$path/apple.png"),
        //     onPressed: () {
        //       _signWithApple();
        //     },
        //   ),
        // FullWidthElevButtonChild(
        //   margin: const EdgeInsets.symmetric(horizontal: 10),
        //   color: kPrimaryWhite,
        //   child: Image.asset("$path/gosuslugi.png"),
        //   onPressed: () {},
        // ),
      ],
    );
  }

  Future<void> _signInWithVk(BuildContext context) async {
    if (!vk.isInitialized) {
      await vk.initSdk();
    }

    final res = await vk.logIn(
      scope: [
        VKScope.email,
        VKScope.phone,
      ],
    );

// Check result
    if (res.isValue) {
      // There is no error, but we don't know yet
      // if user loggen in or not.
      // You should check isCanceled
      final VKLoginResult data = res.asValue!.value;

      if (res.isError) {
        // User cancel log in
      } else {
        final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
        final email = await vk.getUserEmail();
        final profile = (await vk.getUserProfile()).asValue!.value!;
        // Logged in

        if (email == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpWithPhone(
                userModel: UserModel(
                  email: email,
                  firstname: profile.firstName,
                  lastname: profile.lastName,
                ),
              ),
            ),
          );
        } else {
          // authBloc.add(SignInWithGoogle(user, context));
        }
        // Send access token to server for validation and auth
        final VKAccessToken accessToken = res.asValue!.value.accessToken!;
        print('Access token: ${accessToken.token}');

        // Get profile data
        print('Hello, ${profile.firstName}! You ID: ${profile.userId}');
        print('Hello, ${profile.phone}! You ID: ${profile.userId}');

        // Get email (since we request email permissions)
        print('And your email is $email');
      }
    } else {
      // Log in failed
      final errorRes = res.asError;
      print('Error while log in: ${errorRes?.error}');
    }
  }

  void _signWithGoogle(BuildContext context) async {
    final google = GoogleSignIn();
    final user = await google.signIn();

    if (user == null) {
      // _btnGoogle.error();
      return;
    }

    final googleAuth = await user.authentication;
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    print(user.email);
    print(user);
    authBloc.add(SignInWithGoogle(user, context));

    // _btnGoogle.success();

    // await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _signWithApple() async {
    try {
      final appleId = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print(appleId.email);
      print(appleId.familyName);
      print(appleId.givenName);
      print(appleId.userIdentifier);
      print(appleId.identityToken);
      // _btnApple.success();

      // await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // _btnApple.error();
    }
  }
}
