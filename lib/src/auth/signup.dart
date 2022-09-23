import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/auth/components/social_buttons.dart';
import 'package:app_poezdka/src/auth/signup_email_phone.dart';
import 'package:app_poezdka/widget/button/full_width_leveated_button_child.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Регистрация",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _authSection()),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Text(
                "Уже есть аккаунт? Войти.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _authSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25, top: 10, bottom: 8),
          child: Text(
            "Регистрация через:",
            style: TextStyle(color: kPrimaryLightGrey),
          ),
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: const Text("E-mail или телефон"),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignUpWithEmailPhone())),
        ),
        // SocialAuthButtons(),
      ],
    );
  }
}
