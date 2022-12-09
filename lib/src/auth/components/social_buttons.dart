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
            ],
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => WebViewPage())));
          },
        ),
      ],
    );
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

      print(
          'log ${appleCredential}-${appleCredential.email}-${appleCredential.familyName}-${appleCredential.givenName}');

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
      print('log $displayName');
    } catch (exception) {
      print('log $exception');
    }
  }
}

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool visible = true;
  late SecureStorage userRepository = SecureStorage.instance;
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    print('start visible ${visible}');
    return KScaffoldScreen(
      isLeading: true,
      title: 'Вконтакте',
      body: Stack(
        children: [
          WebView(
            backgroundColor: Colors.white,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              if (url.contains('https://oauth.vk.com/authorize') ||
                  url.contains(
                      'http://194.87.145.140/users/login/vk-oauth2/')) {
                setState(() {
                  visible = false;
                });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    visible = true;
                  });
                });
              }
              print('start page ${url}');
            },
            onPageFinished: (url) {
              print('start finish ${url}');
              readJS(context);
              if (url.contains('http://194.87.145.140/users/new_oauth_user')) {
                setState(() {
                  visible = false;
                });
              }
            },
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            initialUrl: authVK,
          ),
          if (!visible)
            Container(
              color: Colors.white,
            )
        ],
      ),
    );
  }

  void readJS(BuildContext context) async {
    String html = await _controller.runJavascriptReturningResult(
        "document.querySelector('body pre').innerHTML");

    final jsons = jsonDecode(html);
    print(jsons);

    VKModel? vkModel;
    if (Platform.isIOS) {
      print('ios');
      vkModel = VKModel.fromJson(jsons);
    } else if (Platform.isAndroid) {
      print('android');
      vkModel = VKModel.fromJson(jsonDecode(jsons));
    }

    if (vkModel != null) {
      if (vkModel.phoneNumber == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpWithPhone(
              userModel: UserModel(
                email: vkModel?.email,
                firstname: vkModel?.firstname,
                lastname: vkModel?.lastname,
                token: vkModel?.token,
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
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AppScreens()),
          (route) => false,
        );
      }
    }
  }
}
