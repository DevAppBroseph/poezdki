



import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/button/full_width_leveated_button_child.dart';
import 'package:flutter/material.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: const Text("Вконтакте"),
          onPressed: () {},
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: const Text("Google Account"),
          onPressed: () {},
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: const Text("Apple ID"),
          onPressed: () {},
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: const Text("ГОСУСЛУГИ"),
          onPressed: () {},
        ),
      ],
    );
  }
}