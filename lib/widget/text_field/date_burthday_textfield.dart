import 'dart:io';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class DateBirthdayTextField extends StatefulWidget {
  final Function? onTap;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final String hintText;
  final Icon? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController dob;
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
  const DateBirthdayTextField(
      {Key? key,
      this.onTap,
      this.readOnly,
      this.inputAction,
      this.focusNode,
      required this.hintText,
      this.icon,
      this.onChanged,
      required this.dob,
      this.mainColor,
      this.bgColor,
      this.maxLines,
      this.formatters,
      this.textInputType,
      this.obscureText,
      this.validateFunction,
      this.suffix,
      this.suffixIcon,
      this.suffixText,
      this.prefixicon})
      : super(key: key);

  @override
  State<DateBirthdayTextField> createState() => _DateBirthdayTextFieldState();
}

class _DateBirthdayTextFieldState extends State<DateBirthdayTextField> {
  final FocusNode nodeText = FocusNode();
  Color textFieldBorderColor = kPrimaryWhite;
  Color hintTextColor = Colors.grey;
  String text = '';

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SizedBox(
        height: 100,
        child: KeyboardActions(
          config: KeyboardActionsConfig(
            defaultDoneWidget: GestureDetector(
              onTap: () => nodeText.unfocus(),
              child: const Text('Готово'),
            ),
            actions: [
              KeyboardActionsItem(
                focusNode: nodeText,
                onTapAction: () => nodeText.unfocus(),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.dob,
            validator: Validations.validateDateBirthday,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            minLines: 1,
            focusNode: nodeText,
            onChanged: (value) {
              if (value[value.length - 1] != '.') {
                if (value.length >= text.length) {
                  if (value.length == 2 || value.length == 5) {
                    widget.dob.text = value + '.';
                    widget.dob.selection = TextSelection.fromPosition(
                        TextPosition(offset: widget.dob.text.length));
                  } else {
                    if (value.length == 3 || value.length == 6) {
                      widget.dob.text = text + '.' + value[value.length - 1];
                      widget.dob.selection = TextSelection.fromPosition(
                          TextPosition(offset: widget.dob.text.length));
                    }
                  }
                }
              }
              text = widget.dob.text;
            },
            cursorColor: kPrimaryColor,
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            keyboardType: TextInputType.number,
            style: const TextStyle(
                color: Colors.black, overflow: TextOverflow.ellipsis),
            decoration: InputDecoration(
              suffixStyle: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              errorStyle: const TextStyle(fontSize: 10.0),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              filled: true,
              fillColor: kPrimaryWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: kPrimaryWhite,
                  width: 0.0,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: kPrimaryWhite,
                  width: 0.0,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: kPrimaryWhite,
                  width: 0.0,
                  style: BorderStyle.solid,
                ),
              ),
              hintStyle: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              hintText: widget.hintText,
            ),
          ),
        ),
      );
    }

    return TextFormField(
      onChanged: (value) {
        if (value[value.length - 1] != '.') {
          if (value.length >= text.length) {
            if (value.length == 2 || value.length == 5) {
              widget.dob.text = value + '.';
              widget.dob.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.dob.text.length));
            } else {
              if (value.length == 3 || value.length == 6) {
                widget.dob.text = text + '.' + value[value.length - 1];
                widget.dob.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.dob.text.length));
              }
            }
          }
        }
        text = widget.dob.text;
      },
      controller: widget.dob,
      validator: Validations.validateDateBirthday,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      minLines: 1,
      inputFormatters: [LengthLimitingTextInputFormatter(10)],
      keyboardType: TextInputType.number,
      style:
          const TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis),
      decoration: InputDecoration(
        suffixStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(fontSize: 10.0),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        filled: true,
        fillColor: kPrimaryWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kPrimaryWhite,
            width: 0.0,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kPrimaryWhite,
            width: 0.0,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kPrimaryWhite,
            width: 0.0,
            style: BorderStyle.solid,
          ),
        ),
        hintStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
