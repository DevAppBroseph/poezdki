import 'dart:convert';
import 'dart:math';

import 'package:app_poezdka/bloc/auth/auth_builder.dart';
import 'package:app_poezdka/const/theme.dart';
import 'package:app_poezdka/model/is_correct.dart';
import 'package:app_poezdka/model/reset_password.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../export/blocs.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController email = TextEditingController();

  final TextEditingController firstPass = TextEditingController();
  final TextEditingController secondPass = TextEditingController();
  TabController? tabController;

  int numberOfPages = 3;
  int currentPage = 0;
  DateTime selectedDate = DateTime.now();
  String? selectedGender;
  ResetPasswordOne? resetPasswordOne;
  IsCorrect? isCorrect;

  int pin = 0;

  final errorDialog = ErrorDialogs();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final infoDialog = InfoDialog();
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    initializeDateFormatting('ru', null);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
          onPressed: () {
            if (currentPage == 0) {
              Navigator.pop(context);
            } else {
              setState(() {
                currentPage--;
                tabController!.animateTo(
                  currentPage,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              });
            }
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            'Восстановление доступа',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                _phonePage(),
                _pinPage(),
                _passPage(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50, right: 15, left: 15),
                child: FullWidthElevButton(
                  title: currentPage != 2 ? "Отправить" : 'Сохранить',
                  onPressed: () async {
                    if (currentPage == 0) {
                      _resetPasswordOne(email.text);
                    } else if (currentPage == 1) {
                      _checkCode(resetPasswordOne!.login, pin);
                    } else if (currentPage == 2) {
                      _resetPasswordConfirm(firstPass.text, secondPass.text);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _passPage() {
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 100, right: 100, top: 80),
          child: Text(
            'Введите новый пароль',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
                child: KFormField(
                  hintText: 'Пароль *',
                  textEditingController: firstPass,
                  validateFunction: Validations.validateEmail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: KFormField(
                  hintText: 'Повторите пароль *',
                  textEditingController: secondPass,
                  validateFunction: Validations.validateEmail,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _resetPasswordOne(String value) async {
    Response res;
    var dio = Dio();

    try {
      res = await dio.post(
        "http://194.87.145.140/users/reset_password",
        options: Options(
          validateStatus: ((status) => status! >= 200),
        ),
        data: jsonEncode({
          "login": value,
        }),
      );
      print(res.data);
      setState(() {
        resetPasswordOne = ResetPasswordOne.fromJson(res.data);
        currentPage++;
        tabController!.animateTo(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      });
    } catch (e) {
      errorDialog.showError('Введите E-Mail.');
    }
  }

  Future<void> _checkCode(String value, int code) async {
    Response res;
    var dio = Dio();

    try {
      res = await dio.post(
        "http://194.87.145.140/users/check_code",
        options: Options(
          validateStatus: ((status) => status! >= 200),
        ),
        data: jsonEncode({
          "login": value,
          "code": code,
        }),
      );
      print(res.data);
      setState(() {
        isCorrect = IsCorrect.fromJson(res.data);
        if (isCorrect!.isCorrect) {
          currentPage++;
          tabController!.animateTo(
            currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        } else {
          errorDialog.showError('Код неправильно указан.');
        }
      });
    } catch (e) {
      errorDialog.showError('Код неправильно указан.');
    }
  }

  Future<void> _resetPasswordConfirm(
    String passwordFirst,
    String passwordSecond,
  ) async {
    if (passwordFirst == passwordSecond) {
      Response res;
      var dio = Dio();

      try {
        res = await dio.post(
          "http://194.87.145.140/users/reset_password_confirm",
          options: Options(validateStatus: ((status) => status! >= 200),
              //TODO add token
              headers: {"Authorization": isCorrect?.token}),
          data: jsonEncode({
            "password": passwordFirst,
          }),
        );
        print(res.data);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AppInitBuilder(),
          ),
          (route) => false,
        );
      } catch (e) {
        errorDialog.showError('Не удалось поменять пароль.');
      }
    } else {
      errorDialog.showError('Не удалось поменять пароль.');
    }
  }

  Column _phonePage() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 80),
          child: Text(
            'Для сброса пароля, введите номер Телефона или E-mail который был указан при регистрации.',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
          child: KFormField(
            hintText: 'Телефон или E-mail *',
            textEditingController: email,
            validateFunction: Validations.validateEmail,
          ),
        ),
      ],
    );
  }

  Column _pinPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 100, top: 80),
          child: Text(
            'Код воостановления отправлен на ${email.text}',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
          child: Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            showCursor: false,
            onCompleted: (pin1) {
              setState(() {
                pin = int.parse(pin1);
              });
            },
            onChanged: (text) async {
              if (text.length == 6) {
                setState(() {
                  pin = int.parse(text);
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
