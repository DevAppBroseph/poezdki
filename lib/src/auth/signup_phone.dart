import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
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
                  hintText: 'Телефон',
                  textEditingController: email,
                  validateFunction: Validations.validateEmail,
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
                              "1) Убедитесь что вы корректно ввели E-mail",
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    );
                  } else {
                    widget.userModel.phone = email.text;
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
