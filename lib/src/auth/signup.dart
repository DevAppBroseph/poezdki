import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/auth/components/social_buttons.dart';
import 'package:app_poezdka/src/auth/confirm_phone_email.dart';
import 'package:app_poezdka/widget/button/full_width_leveated_button_child.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final String? referal;
  const SignUpScreen({Key? key, this.referal}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool personalData = false;

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
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Row(
              children: [
                Checkbox(
                  value: personalData,
                  shape: const CircleBorder(),
                  onChanged: (value) {
                    personalData = !personalData;
                    setState(() {});
                  },
                ),
                const Expanded(
                  child: Text(
                    "Я соглашаюсь с условиями обработки персональных данеых",
                    style: TextStyle(color: kPrimaryLightGrey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
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
        Stack(
          children: [
            Column(
              children: [
                FullWidthElevButtonChild(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: kPrimaryWhite,
                  child: const Text("Телефон"),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPhoneEmailPage(
                        referal: widget.referal,
                      ),
                    ),
                  ),
                ),
                SocialAuthButtons(),
              ],
            ),
            if (!personalData)
              Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
