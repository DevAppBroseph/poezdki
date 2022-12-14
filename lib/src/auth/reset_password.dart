import 'dart:convert';
import 'package:app_poezdka/bloc/auth/auth_builder.dart';
import 'package:app_poezdka/const/theme.dart';
import 'package:app_poezdka/model/country_code.dart';
import 'package:app_poezdka/model/is_correct.dart';
import 'package:app_poezdka/model/reset_password.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:app_poezdka/widget/text_field/phone_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
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
    tabController = TabController(length: 3, vsync: this);
    loadDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      _resetPasswordOne(selectCode + email.text);
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
          padding: EdgeInsets.only(left: 100, right: 100, top: 80),
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
        data: jsonEncode({"login": value, "is_first_auth": false}),
      );
      if (res.statusCode != 200) {
        errorDialog.showError('${res.data}');
      } else {
        // setState(() {
        resetPasswordOne = ResetPasswordOne.fromJson(res.data);
        currentPage++;
        tabController!.animateTo(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        Future.delayed(Duration(milliseconds: 300), (() {
          setState(() {});
        }));
        // });
      }
    } catch (e) {
      errorDialog.showError('Введите Телефон.');
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
        data:
            jsonEncode({"login": value, "code": code, "is_first_auth": false}),
      );
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

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AppInitBuilder(),
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
            'Для сброса пароля, введите номер Телефона который был указан при регистрации.',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
          child: Row(
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
        ),
      ],
    );
  }

  Widget _pinPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 100, top: 80),
          child: Text(
            'Код воостановления отправлен на ${selectCode + email.text}',
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
