import 'dart:convert';
import 'package:app_poezdka/model/country_code.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../export/blocs.dart';

class SignUpWithPhone extends StatefulWidget {
  UserModel userModel;
  SignUpWithPhone({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<SignUpWithPhone> createState() => _SignUpWithPhoneState();
}

class _SignUpWithPhoneState extends State<SignUpWithPhone> {
  final TextEditingController email = TextEditingController();

  int numberOfPages = 3;
  int currentPage = 0;
  DateTime selectedDate = DateTime.now();
  String? selectedGender;
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
    super.initState();
    loadDB();
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
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            'Введите номер телефона',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
                child: KFormField(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, right: 15, left: 15),
              child: FullWidthElevButton(
                title: "Зарегистрироваться",
                onPressed: () async {
                  if (email.text.isEmpty) {
                    infoDialog.show(
                      title: "Что то не так:",
                      children: const [
                        ListTile(
                          title: Text(
                              "1) Убедитесь что вы корректно ввели Телефон.",
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    );
                  } else {
                    widget.userModel.phone = selectCode + email.text;
                    authBloc.add(
                      SignInWithVk(widget.userModel, context),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
