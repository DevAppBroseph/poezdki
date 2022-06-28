import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';

class KDivider extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String text;
  const KDivider({Key? key, this.margin, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ??
          const EdgeInsets.only(top: 30, bottom: 20, left: 25, right: 25),
      child: Row(children:  <Widget>[
        const Expanded(child:  Divider()),
        Text(
          "     $text     ",
          style: const TextStyle(color: kPrimaryLightGrey),
        ),
        const Expanded(child:  Divider()),
      ]),
    );
  }
}
