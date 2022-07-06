import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';

class FullWidthElevButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Alignment? alignment;
  final Color? color;
  final Function? onPressed;
  final String title;
  final TextStyle? titleStyle;
  const FullWidthElevButton(
      {Key? key,
      this.alignment,
      this.color,
      this.onPressed,
      required this.title,
      this.titleStyle,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
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
          padding: const EdgeInsets.all(5.0),
          child: Text(
            title,
            style: titleStyle ?? const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


