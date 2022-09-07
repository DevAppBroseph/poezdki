import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/src/auth/components/social_buttons.dart';
import 'package:app_poezdka/src/auth/reset_password.dart';
import 'package:app_poezdka/src/auth/signup.dart';
import 'package:app_poezdka/src/policy/policy.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/divider/row_divider.dart';
import 'package:app_poezdka/widget/text_field/custom_password_text_field.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        title: const Text(
          "Вход",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _authForm(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    pushNewScreen(context, screen: const WebViewPage());
                  },
                  child: const Text('Политика конфиденциальности'),
                ),
              ),
            ),
            const KDivider(text: "Войти через"),
            SocialAuthButtons(),
            _singInButton(context),
            _restorePassword(),
            _signUp(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _authForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
          child: Column(
        children: [
          KFormField(
            hintText: 'Телефон или E-mail',
            textEditingController: email,
          ),
          KPasswordField(
            hintText: 'Пароль',
            controller: pw,
          ),
        ],
      )),
    );
  }

  Widget _singInButton(context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    return FullWidthElevButton(
      margin: const EdgeInsets.fromLTRB(10, 60, 10, 5),
      title: "Войти",
      onPressed: () {
        if (email.text.isEmpty && pw.text.isEmpty) {
          ErrorDialogs().showError('Поля не заполнены.');
        } else {
          authBloc.add(LoggedIn(context, email.text, pw.text));
        }
      },
    );
  }

  Widget _restorePassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordPage(),
            ),
          );
        },
        child: const Text(
          "Забыли пароль?",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  Widget _signUp() {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignUpScreen())),
      child: const Text(
        "Регистрация",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
      ),
    );
  }
}
