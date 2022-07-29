import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class SuggestSignIn extends StatelessWidget {
  const SuggestSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        title: "",
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            FullWidthElevButton(
              title: "Авторизироваться",
              onPressed: () {},
            )
          ],
        ));
  }
}
