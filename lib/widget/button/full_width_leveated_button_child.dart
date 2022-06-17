import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';

class FullWidthElevButtonChild extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Alignment? alignment;
  final Color? color;
  final Function? onPressed;
  final Widget child;

  const FullWidthElevButtonChild({
    Key? key,
    this.margin,
    this.alignment,
    this.color,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: margin ?? const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          alignment: alignment ?? Alignment.center,
          side: BorderSide(color: color ?? kPrimaryColor),
          padding: const EdgeInsets.all(10.0),
          primary: color ?? kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

          // primary: ThemeProvider.optionsOf<MyThemeOptions>(context)
          //     .blackThemeBlackColor,
        ),
        onPressed: onPressed as void Function()?,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }
}
