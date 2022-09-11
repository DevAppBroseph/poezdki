import 'package:app_poezdka/service/server/user_service.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class Offert extends StatefulWidget {
  const Offert({Key? key}) : super(key: key);

  @override
  State<Offert> createState() => _OffertState();
}

class _OffertState extends State<Offert> {
  String? text;
  @override
  void initState() {
    super.initState();
    UserService().getOffer().then((value) {
      setState(() {
        text = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "Публичная оферта",
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(text != null ? text! : ''),
              ],
            ),
          ),
        ));
  }
}
