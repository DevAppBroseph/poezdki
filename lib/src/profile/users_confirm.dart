import 'package:app_poezdka/service/server/user_service.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class UsersConfirm extends StatefulWidget {
  const UsersConfirm({Key? key}) : super(key: key);

  @override
  State<UsersConfirm> createState() => _UsersConfirmState();
}

class _UsersConfirmState extends State<UsersConfirm> {
  String? text;
  @override
  void initState() {
    super.initState();
    UserService().getPolitic().then((value) {
      setState(() {
        text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "Пользовательское соглашение",
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Text(
                  text != null ? text! : '',
                  style: const TextStyle(fontSize: 17),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ));
  }
}
