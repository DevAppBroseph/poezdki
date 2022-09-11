import 'package:app_poezdka/service/server/user_service.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class AboutProject extends StatefulWidget {
  const AboutProject({Key? key}) : super(key: key);

  @override
  State<AboutProject> createState() => _AboutProjectState();
}

class _AboutProjectState extends State<AboutProject> {
  String? text;
  @override
  void initState() {
    super.initState();
    UserService().getInfo().then((value) {
      setState(() {
        text = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "О проекте",
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
