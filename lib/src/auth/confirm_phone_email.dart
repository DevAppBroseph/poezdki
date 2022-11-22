import 'dart:convert';
import 'package:app_poezdka/const/theme.dart';
import 'package:app_poezdka/model/country_code.dart';
import 'package:app_poezdka/model/is_correct.dart';
import 'package:app_poezdka/model/reset_password.dart';
import 'package:app_poezdka/src/auth/signup_email_phone.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class ConfirmPhoneEmailPage extends StatefulWidget {
  const ConfirmPhoneEmailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmPhoneEmailPage> createState() =>
      _ConfirmPhoneEmailPagePageState();
}

class _ConfirmPhoneEmailPagePageState extends State<ConfirmPhoneEmailPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController email = TextEditingController();

  final TextEditingController firstPass = TextEditingController();
  final TextEditingController secondPass = TextEditingController();
  TabController? tabController;

  int numberOfPages = 2;
  int currentPage = 0;
  DateTime selectedDate = DateTime.now();
  String? selectedGender;
  ResetPasswordOne? resetPasswordOne;
  IsCorrect? isCorrect;

  int pin = 0;

  final errorDialog = ErrorDialogs();
  final btmSheet = BottomSheetCallAwait();

  CountryCode? countryCode;
  int maxLength = 10;
  String selectCode = '+7';

  void loadDB() async {
    String str = await rootBundle.loadString('assets/phone/code_phone.json');
    countryCode = CountryCode.fromJson(json.decode(str));
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    loadDB();
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
            'Подтвердите ваши данные',
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
                      _sendPhoneEmail(email.text);
                    } else if (currentPage == 1) {
                      _checkCode(selectCode + resetPasswordOne!.login, pin);
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

  Future<void> _sendPhoneEmail(String value) async {
    pin = 0;
    Response res;
    var dio = Dio();

    try {
      res = await dio.post(
        "http://194.87.145.140/users/reset_password",
        options: Options(
          validateStatus: ((status) => status! >= 200),
        ),
        data: jsonEncode({"login": '$selectCode$value', "is_first_auth": true}),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        setState(() {
          resetPasswordOne = ResetPasswordOne.fromJson(res.data);
          currentPage++;
          tabController!.animateTo(
            currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      } else {
        errorDialog.showError(res.data);
      }
    } catch (e) {
      errorDialog.showError('Введите Телефон.');
      currentPage++;
      tabController!.animateTo(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
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
        data: jsonEncode({"login": value, "code": code, "is_first_auth": true}),
      );
      setState(() {
        isCorrect = IsCorrect.fromJson(res.data);
        if (isCorrect!.isCorrect) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpWithEmailPhone(
                      phoneEmail: selectCode + email.text)));
        } else {
          errorDialog.showError('Код неправильно указан.');
        }
      });
    } catch (e) {
      errorDialog.showError('Код неправильно указан.');
    }
  }

  Column _phonePage() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 80),
          child: Text(
            'Для сброса кода, введите\nномер Телефона.',
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 18, bottom: 18),
          child: Row(
            children: [
              Expanded(
                child: KFormField(
                  textInputType: TextInputType.number,
                  prefixicon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
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
                  ),
                  hintText: 'Телефон',
                  textEditingController: email,
                  validateFunction: Validations.validateEmail,
                  formatters: [LengthLimitingTextInputFormatter(maxLength)],
                ),
              ),
            ],
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
            'Код восстановления отправлен на ${email.text}',
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
              // setState(() {
              pin = int.parse(pin1);
              // });
            },
            onChanged: (text) async {
              // if (text.length == 6) {
              //   setState(() {
              pin = int.parse(text);
              // });
              // }
            },
          ),
        ),
      ],
    );
  }
}
