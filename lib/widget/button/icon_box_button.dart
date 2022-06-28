import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';

class IconBoxButton extends StatelessWidget {
  final Widget child;
  const IconBoxButton({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
       borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kPrimaryWhite),
        height: 55,
        width: 55,
        child: child,
      ),
    );
  }
}
