import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/auth/components/signup_account_info.dart';
import 'package:app_poezdka/src/auth/components/signup_personal_info.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../export/blocs.dart';

class SignUpWithEmailPhone extends StatefulWidget {
  const SignUpWithEmailPhone({Key? key, required this.phoneEmail})
      : super(key: key);
  final String phoneEmail;

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

  bool personalData = false;

  @override
  Widget build(BuildContext context) {
    email.text = widget.phoneEmail;
    final infoDialog = InfoDialog();
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    initializeDateFormatting('ru', null);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () {
              if (currentPage == 1) {
                controller.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
            )),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: RichText(
            text: TextSpan(
                text: 'Регистрация',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' ${currentPage == 0 ? 1 : 2}/2',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
                  // onPickDob: () => _pickDate(),
                  dob: dob,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (currentPage == 1)
                  Row(
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
                FullWidthElevButton(
                  title: currentPage == 1 ? "Погнали!" : "Еще немного!",
                  onPressed: () async {
                    if (currentPage == 0 &&
                        _regFormAccount.currentState!.validate() == false && !personalData) {
                      infoDialog.show(
                        title: "Что то не так:",
                        children: const [
                          ListTile(
                            title: Text(
                                "1) Убедитесь что вы корректно ввели Телефон или E-mail",
                                style: TextStyle(fontSize: 14)),
                          ),
                          ListTile(
                              title: Text(
                                  "2) Пароль должен содержать минимум 8 символов",
                                  style: TextStyle(fontSize: 14))),
                          ListTile(
                              title: Text(
                            "3) Убедитесь что введенные пароли совпадают",
                            style: TextStyle(fontSize: 14),
                          )),
                        ],
                      );
                    } else if (currentPage == 0 &&
                        _regFormAccount.currentState!.validate()) {
                      setState(() {
                        currentPage++;
                        controller.animateToPage(currentPage++,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                      });
                    } else if (currentPage == 1 &&
                        _regFormPersonal.currentState!.validate() && personalData) {
                      final parseDate = dob.text.split('.');
                      final date = DateTime.parse(
                          '${parseDate[2]}-${parseDate[1]}-${parseDate[0]} 00:00:00.000');

                      authBloc.add(
                        SignUp(
                          context: context,
                          login: email.text,
                          password: pw.text,
                          firstName: name.text,
                          lastName: surname.text,
                          gender: selectedGender!,
                          birth: date.millisecondsSinceEpoch,
                        ),
                      );

                      // authBloc.add(LoggedIn(email, token))

                      /// Local auth db

                      /// Server auth
                      //   authBloc.add(SignUp(
                      //       login: email.text,
                      //       password: pw.text,
                      //       userModel: UserModel(
                      //           firstName: name.text,
                      //           lastName: surname.text,
                      //           gender: selectedGender!,
                      //           birth: selectedDate.millisecondsSinceEpoch)));
                      // }

                      //Dev login
                      // setState(() {
                      //   currentPage++;
                      //   controller.animateToPage(currentPage++,
                      //       duration: const Duration(seconds: 1),
                      //       curve: Curves.fastLinearToSlowEaseIn);
                      // });
                      // final auth = AuthService();
                      // auth.signUp(
                      //     login: "login@mail.ru",
                      //     password: "123456",
                      //     firstName: "John",
                      //     lastName: "Doe",
                      //     gender: "male",
                      //     birth: DateTime.now().millisecondsSinceEpoch);
                    }
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
      final dateFormat = DateFormat.yMd('ru').format(picked);
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
                        gender.text = "Мужской";
                        selectedGender = "male";
                        Navigator.pop(context);
                      }),
                      title: const Text("Мужской"),
                    ),
                    ListTile(
                      onTap: () => setState(() {
                        gender.text = "Женский";
                        selectedGender = "female";
                        Navigator.pop(context);
                      }),
                      title: const Text("Женский"),
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
