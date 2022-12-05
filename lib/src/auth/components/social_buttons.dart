import 'dart:convert';
import 'dart:io';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/server/server_user.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/model/vk.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/src/app_screens.dart';
import 'package:app_poezdka/src/auth/signup_phone.dart';
import 'package:app_poezdka/widget/button/full_width_leveated_button_child.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialAuthButtons extends StatelessWidget {
  SocialAuthButtons({Key? key}) : super(key: key);

  final vk = VKLogin();

  @override
  Widget build(BuildContext context) {
    const path = "assets/img";
    return Column(
      children: [
        if (Platform.isIOS)
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 0,
              bottom: 10,
            ),
            child: SignInWithAppleButton(
              style: SignInWithAppleButtonStyle.black,
              onPressed: () => signInWithApple(context),
            ),
          ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "$path/vk_login.png",
                width: 104,
                height: 24,
              ),
              // const Text(
              //   "   Вконтакте",
              //   style: TextStyle(fontWeight: FontWeight.w600),
              // )
            ],
          ),
          onPressed: () {
            _signInWithVk(context);
          },
        ),
        // FullWidthElevButtonChild(
        //   margin: const EdgeInsets.symmetric(horizontal: 10),
        //   color: kPrimaryWhite,
        //   child: Image.asset(
        //     "$path/google_login.png",
        //     width: 136,
        //     height: 24,
        //   ),
        //   onPressed: () {
        //     _signWithGoogle(context);
        //   },
        // ),
        // FullWidthElevButtonChild(
        //   margin: const EdgeInsets.symmetric(horizontal: 10),
        //   color: kPrimaryWhite,
        //   child: Image.asset(
        //     "$path/apple_login.png",
        //     width: 89,
        //     height: 29.49,
        //   ),
        //   onPressed: () {
        //     signInWithApple(context);
        //   },
        // ),
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
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => WebViewPage())));
//     if (!vk.isInitialized) {
//       await vk.initSdk();
//     }

//     final res = await vk.logIn(
//       scope: [
//         VKScope.email,
//         // VKScope.phone,
//       ],
//     );

// // Check result
//     if (res.isValue) {
//       // There is no error, but we don't know yet
//       // if user loggen in or not.
//       // You should check isCanceled
//       final VKLoginResult data = res.asValue!.value;

//       if (res.isError) {
//         // User cancel log in
//       } else {
//         final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
//         final email = await vk.getUserEmail();
//         final profile = (await vk.getUserProfile()).asValue!.value!;
//         VKUserProfile ;
//         // Logged in

//         if (email == null) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SignUpWithPhone(
    //       userModel: UserModel(
    //         email: email,
    //         firstname: profile.firstName,
    //         lastname: profile.lastName,
    //       ),
    //     ),
    //   ),
    // );
//         } else {
//           // authBloc.add(SignInWithGoogle(user, context));
//         }
//         // Send access token to server for validation and auth
//         final VKAccessToken accessToken = res.asValue!.value.accessToken!;
//         print('Access token: ${accessToken.token}');

//         // Get profile data
//         print('Hello, ${profile.firstName}! You ID: ${profile.userId}');
//         // print('Hello, ${profile.phone}! You ID: ${profile.userId}');

//         // Get email (since we request email permissions)
//         print('And your email is $email');
//       }
//     } else {
//       // Log in failed
//       final errorRes = res.asError;
//       print('Error while log in: ${errorRes?.error}');
//     }
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
    authBloc.add(SignInWithGoogle(user, context));
  }

  void signInWithApple(BuildContext context) async {
    final rawNonce = generateNonce();

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // nonce: nonce,
      );

      print(appleCredential);
      

      if (appleCredential.email != null) {
        BlocProvider.of<AuthBloc>(context).add(
          SignInWithVk(
            UserModel(
              email: appleCredential.email,
              firstname: appleCredential.givenName,
              lastname: appleCredential.familyName,
            ),
            context,
          ),
        );
      }
      final displayName =
          '${appleCredential.givenName} ${appleCredential.familyName}';
      final userEmail = '${appleCredential.email}';

      // print(appleCredential);
      print(displayName);
    } catch (exception) {
      print(exception);
    }
  }
}

class WebViewPage extends StatelessWidget {
  WebViewPage({Key? key}) : super(key: key);

  late SecureStorage userRepository = SecureStorage.instance;
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      isLeading: true,
      title: 'Вконтакте',
      body: WebView(
        backgroundColor: Colors.white,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
          readJS(context);
        },
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        initialUrl: authVK,
      ),
    );
  }

  void readJS(BuildContext context) async {
    String html = await _controller
        .runJavascriptReturningResult("document.querySelector('body pre').innerHTML");

    final jsons = jsonDecode(html);

    VKModel? vkModel = VKModel.fromJson(json.decode(jsons));

    if (vkModel != null) {
      if (vkModel.phoneNumber == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpWithPhone(
              userModel: UserModel(
                email: vkModel.email,
                firstname: vkModel.firstname,
                lastname: vkModel.lastname,
                token: vkModel.token,
              ),
            ),
          ),
        );
      } else {
        await userRepository.persistEmailAndToken(
          vkModel.email,
          vkModel.token,
          vkModel.id,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AppScreens()),
          (route) => false,
        );
      }
    }
  }
}
