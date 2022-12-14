import 'dart:io';
import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KFormField extends StatelessWidget {
  final Function? onTap;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final String hintText;
  final Icon? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController textEditingController;
  final Color? mainColor;
  final Color? bgColor;
  final int? maxLines;
  final List<TextInputFormatter>? formatters;
  final TextInputType? textInputType;
  final bool? obscureText;
  final FormFieldValidator<String>? validateFunction;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? suffixText;
  final Widget? prefixicon;
  final String? prefixText;
  final bool? enabled;
  final bool? center;
  final double? fontSize;
  final EdgeInsets? contentPadding;
  const KFormField({
    Key? key,
    this.onTap,
    this.readOnly,
    this.inputAction,
    this.focusNode,
    required this.hintText,
    this.icon,
    this.onChanged,
    required this.textEditingController,
    this.mainColor,
    this.bgColor,
    this.center,
    this.fontSize,
    this.maxLines,
    this.formatters,
    this.textInputType,
    this.obscureText,
    this.validateFunction,
    this.suffix,
    this.suffixIcon,
    this.suffixText,
    this.prefixicon,
    this.prefixText,
    this.enabled,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode nodeText = FocusNode();
    Color textFieldBorderColor = kPrimaryWhite;
    Color hintTextColor = Colors.grey;

    var widthOfScreen = MediaQuery.of(context).size.width;
    var contentPadding = this.contentPadding ??
        const EdgeInsets.symmetric(vertical: 20, horizontal: 20);
    return SizedBox(
      height: 75,
      width: widthOfScreen,
      child: 
      // Platform.isAndroid
      //     ? TextFormField(
      //         enabled: enabled,
      //         focusNode: focusNode,
      //         onTap: onTap as void Function()?,
      //         validator: validateFunction,
      //         readOnly: readOnly ?? false,
      //         textInputAction: inputAction,
      //         controller: textEditingController,
      //         onChanged: onChanged,
      //         cursorColor: kPrimaryColor,
      //         obscureText: obscureText ?? false,
      //         maxLines: 1,
      //         minLines: 1,
      //         textAlign: center != null
      //             ? center!
      //                 ? TextAlign.center
      //                 : TextAlign.start
      //             : TextAlign.start,
      //         inputFormatters: formatters,
      //         keyboardType: textInputType,
      //         style: TextStyle(
      //             color: Colors.black,
      //             overflow: TextOverflow.ellipsis,
      //             fontSize: fontSize),
      //         decoration: InputDecoration(
      //             icon: icon,
      //             prefixIcon: prefixicon,
      //             suffixText: suffixText,
      //             suffix: suffix,
      //             prefixText: prefixText,
      //             prefixStyle: const TextStyle(
      //                 fontSize: 14.5,
      //                 color: Colors.black,
      //                 overflow: TextOverflow.ellipsis),
      //             suffixIcon: suffixIcon,
      //             suffixStyle: TextStyle(
      //               overflow: TextOverflow.ellipsis,
      //               fontSize: 14,
      //               color: hintTextColor,
      //               fontWeight: FontWeight.w400,
      //             ),
      //             errorStyle: const TextStyle(fontSize: 10.0),
      //             contentPadding: EdgeInsets.symmetric(
      //                 vertical: 20, horizontal: center != null ? 0 : 15),
      //             filled: true,
      //             fillColor: kPrimaryWhite,
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(10),
      //               borderSide: BorderSide(
      //                 color: textFieldBorderColor,
      //                 width: 0.0,
      //                 style: BorderStyle.solid,
      //               ),
      //             ),
      //             focusedBorder: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(10),
      //               borderSide: BorderSide(
      //                 color: textFieldBorderColor,
      //                 width: 0.0,
      //                 style: BorderStyle.solid,
      //               ),
      //             ),
      //             enabledBorder: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(10),
      //               borderSide: BorderSide(
      //                 color: textFieldBorderColor,
      //                 width: 0.0,
      //                 style: BorderStyle.solid,
      //               ),
      //             ),
      //             hintStyle: TextStyle(
      //               overflow: TextOverflow.ellipsis,
      //               fontSize: 14,
      //               color: hintTextColor,
      //               fontWeight: FontWeight.w400,
      //             ),
      //             hintText: hintText),
      //       )
      //     : 
          KeyboardActions(
              config: KeyboardActionsConfig(
                defaultDoneWidget: GestureDetector(
                  onTap: () => nodeText.unfocus(),
                  child: const Text('????????????'),
                ),
                actions: [
                  KeyboardActionsItem(
                    focusNode: nodeText,
                    onTapAction: () => nodeText.unfocus(),
                  ),
                ],
              ),
              child: TextFormField(
                enabled: enabled,
                textAlign: center != null
                    ? center!
                        ? TextAlign.center
                        : TextAlign.start
                    : TextAlign.start,
                focusNode: nodeText,
                onTap: onTap as void Function()?,
                validator: validateFunction,
                readOnly: readOnly ?? false,
                textInputAction: inputAction,
                controller: textEditingController,
                onChanged: onChanged,
                cursorColor: kPrimaryColor,
                obscureText: obscureText ?? false,
                maxLines: 1,
                minLines: 1,
                inputFormatters: formatters,
                keyboardType: textInputType,
                style: const TextStyle(
                    color: Colors.black, overflow: TextOverflow.ellipsis),
                decoration: InputDecoration(
                    icon: icon,
                    prefixIcon: prefixicon,
                    suffixText: suffixText,
                    suffix: suffix,
                    prefixText: prefixText,
                    prefixStyle: const TextStyle(
                        fontSize: 14.5,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis),
                    suffixIcon: suffixIcon,
                    suffixStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      color: hintTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
                    contentPadding: contentPadding,
                    filled: true,
                    fillColor: kPrimaryWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: textFieldBorderColor,
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: textFieldBorderColor,
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: textFieldBorderColor,
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    hintStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      color: hintTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: hintText),
              ),
            ),
    );
  }
}
