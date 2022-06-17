import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/auth/components/social_buttons.dart';
import 'package:app_poezdka/src/auth/signup.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/text_field/custom_password_text_field.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

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
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Вход",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _authForm(),
            _div(),
            const SocialAuthButtons(),
            _singInButton(),
            _restorePassword(),
            _signUp()
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
              hintText: 'Телефон или E-mail', textEditingController: email),
          KPasswordField(
            hintText: 'Пароль',
            controller: pw,
          ),
        ],
      )),
    );
  }

  Widget _div() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20, left: 25, right: 25),
      child: Row(children: const <Widget>[
        Expanded(child: Divider()),
        Text(
          "     Войти через     ",
          style: TextStyle(color: kPrimaryLightGrey),
        ),
        Expanded(child: Divider()),
      ]),
    );
  }

  Widget _singInButton() {
    return FullWidthElevButton(
      margin: const EdgeInsets.fromLTRB(10, 60, 10, 5),
      title: "Войти",
      onPressed: () {},
    );
  }

  Widget _restorePassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {},
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
