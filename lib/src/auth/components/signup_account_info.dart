import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/text_field/custom_password_text_field.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpAccountInfo extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController pw;
  final TextEditingController pwConfirm;
  const SignUpAccountInfo(
      {Key? key,
      required this.formKey,
      required this.email,
      required this.pw,
      required this.pwConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            KFormField(
              hintText: 'Телефон или E-mail*',
              textEditingController: email,
              validateFunction: Validations.validateEmail,
            ),
            KPasswordField(
              hintText: 'Пароль*',
              controller: pw,
              validateFunction: validatePassword2,
            ),
            KPasswordField(
              hintText: 'Повторите пароль*',
              controller: pwConfirm,
              validateFunction: validatePassword2,
            ),
          ],
        ),
      ),
    );
  }

  String? validatePassword2(String? value) {
    if (value!.isEmpty || value != pwConfirm.text) {
      return 'Пароли не совпадают.';
    }
    return null;
  }
}
