import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/button/full_width_leveated_button_child.dart';
import 'package:flutter/material.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const path = "assets/img";
    return Column(
      children: [
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("$path/vk.png"),
              const Text("   Вконтакте", style: TextStyle(fontWeight: FontWeight.w600),)
            ],
          ),
          onPressed: () {},
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: Image.asset("$path/google.png"),
          onPressed: () {},
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: Image.asset("$path/apple.png"),
          onPressed: () {},
        ),
        FullWidthElevButtonChild(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          color: kPrimaryWhite,
          child: Image.asset("$path/gosuslugi.png"),
          onPressed: () {},
        ),
      ],
    );
  }
}
