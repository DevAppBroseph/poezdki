import 'dart:convert';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/country_code.dart';
import 'package:app_poezdka/src/auth/reset_password.dart';
import 'package:app_poezdka/src/auth/signup.dart';
import 'package:app_poezdka/src/policy/policy.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_password_text_field.dart';
import 'package:app_poezdka/widget/text_field/phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pw = TextEditingController();

  CountryCode? countryCode;
  int maxLength = 10;
  String selectCode = '+7';
  final btmSheet = BottomSheetCallAwait();

  void loadDB() async {
    String str = await rootBundle.loadString('assets/phone/code_phone.json');
    countryCode = CountryCode.fromJson(json.decode(str));
  }

  @override
  void initState() {
    loadDB();
    super.initState();
  }

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
            // const KDivider(text: "Войти через"),
            // SocialAuthButtons(),
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
          Row(
            children: [
              PhoneTextField(
                hintText: 'Телефон',
                prefixIcon: GestureDetector(
                  onTap: () async {
                    Country? select = await btmSheet.wait(
                      context,
                      useRootNavigator: true,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          itemCount: countryCode!.country.length,
                          itemBuilder: ((context, index) {
                            return MaterialButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(countryCode!.country[index]);
                              },
                              child: SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        countryCode!.country[index].name!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      countryCode!.country[index].dialCode!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                    if (select != null) {
                      setState(() {
                        maxLength = int.parse(select.lengthPhone!) -
                            select.dialCode!.length;
                        selectCode = select.dialCode!;
                      });
                    }
                  },
                  child: SizedBox(
                    width: 60,
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        selectCode,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                controller: email,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
              )
            ],
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
          authBloc.add(LoggedIn(context, selectCode + email.text, pw.text));
          // authBloc.add(LoggedIn(context, 'bochko000000@gmail.com', '123'));
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
              builder: (context) => const ResetPasswordPage(),
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
