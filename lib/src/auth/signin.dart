import 'package:app_poezdka/service/db_service/auth_db.dart';
import 'package:app_poezdka/src/auth/components/social_buttons.dart';
import 'package:app_poezdka/src/auth/signup.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/divider/row_divider.dart';
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
            const KDivider(text: "Войти через"),
            const SocialAuthButtons(),
            _singInButton(context),
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

  Widget _singInButton(context) {
    final dbAuth = AuthDB();
    // final authBloc = BlocProvider.of<AuthBloc>(context);
    return FullWidthElevButton(
      margin: const EdgeInsets.fromLTRB(10, 60, 10, 5),
      title: "Войти",
      onPressed: () {
        dbAuth.signIn(context, login: email.text, password: pw.text);
        // authBloc.add(OnDevLogIn());
      },
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
