import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/auth/components/signup_account_info.dart';
import 'package:app_poezdka/src/auth/components/signup_personal_info.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SignUpWithEmailPhone extends StatefulWidget {
  const SignUpWithEmailPhone({Key? key}) : super(key: key);

  @override
  State<SignUpWithEmailPhone> createState() => _SignUpWithEmailPhoneState();
}

class _SignUpWithEmailPhoneState extends State<SignUpWithEmailPhone> {
  final GlobalKey<FormState> _regFormAccount = GlobalKey<FormState>();
  final GlobalKey<FormState> _regFormPersonal = GlobalKey<FormState>();

  final PageController controller = PageController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pw = TextEditingController();
  final TextEditingController pwConfirm = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController dob = TextEditingController();

  int numberOfPages = 3;
  int currentPage = 0;
  DateTime selectedDate = DateTime.now();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru', null);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
            )),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: RichText(
            text: const TextSpan(
                text: 'Регистрация',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: ' 1/2',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ]),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                SignUpAccountInfo(
                    formKey: _regFormAccount,
                    email: email,
                    pw: pw,
                    pwConfirm: pwConfirm),
                SignUpPersonalInfo(
                    formKey: _regFormPersonal,
                    name: name,
                    surname: surname,
                    selectedDate: selectedDate,
                    genderCrl: gender,
                    onPickGender: () => _pickGender(),
                    onPickDob: () => _pickDate(),
                    dob: dob)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Нажимая кнопку, вы соглашаетесь с условиями обработки персональных данеых",
                  style: TextStyle(color: kPrimaryLightGrey),
                  textAlign: TextAlign.center,
                ),
                FullWidthElevButton(
                  title: currentPage == 1 ? "Зарегистрироваться" : "Далее",
                  onPressed: () {
                    // if (currentPage == 0 &&
                    //     _regFormAccount.currentState!.validate()) {
                    //   setState(() {
                    //     currentPage++;
                    //     controller.animateToPage(currentPage++,
                    //         duration: Duration(seconds: 1),
                    //         curve: Curves.fastLinearToSlowEaseIn);
                    //   });
                    // }
                    // if (currentPage == 1 &&
                    //     _regFormPersonal.currentState!.validate()) {
                    //   ///TODO: Navigate to home screen
                    // }
                    setState(() {
                      currentPage++;
                      controller.animateToPage(currentPage++,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn);
                    });
                  },
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Уже есть аккаунт? Войти.",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      final dateFormat = DateFormat.yMMMMd('ru').format(picked);
      setState(() {
        selectedDate = picked;
        dob.text = dateFormat;
        // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
      });
    }
  }

  void _pickGender() {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        builder: (context) => Material(
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () => setState(() {
                        selectedGender = "Мужской";
                      }),
                      title: Text("Мужской"),
                    ),
                    ListTile(
                      onTap: () => setState(() {
                        selectedGender = "Женский";
                      }),
                      title: Text("Женский"),
                    ),
                  ],
                ),
              ),
            ));
  }

  String? validatePassword2(String? value) {
    if (value!.isEmpty || value != pwConfirm.text) {
      return 'Пароли не совпадают.';
    }
    return null;
  }
}
