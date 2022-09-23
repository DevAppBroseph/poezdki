// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextField extends StatefulWidget {
  final String? initialValue;
  final bool? enabled;
  final String? hintText;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool? obscureText;
  final FormFieldValidator<String>? validateFunction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onSaved, onChange;
  final Key? fieldKey;
  final Widget? prefixIcon;
  final IconData? suffix;

  const PhoneTextField(
      {this.prefixIcon,
      this.suffix,
      this.initialValue,
      this.enabled,
      this.hintText,
      this.textInputType,
      required this.controller,
      this.inputFormatters,
      this.textInputAction,
      this.nextFocusNode,
      this.focusNode,
      this.submitAction,
      this.obscureText = false,
      this.validateFunction,
      this.onSaved,
      this.onChange,
      this.fieldKey});

  @override
  PhoneTextFieldState createState() => PhoneTextFieldState();
}

class PhoneTextFieldState extends State<PhoneTextField> {
  String? error;
  // bool obscureText = true;
  Color hintTextColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width - 50;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 75,
          width: widthOfScreen,
          child: TextFormField(
            initialValue: widget.initialValue,
            enabled: widget.enabled,
            key: widget.fieldKey,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            validator: widget.validateFunction,
            inputFormatters: widget.inputFormatters,
            onSaved: (val) {
              error = widget.validateFunction!(val);
              setState(() {});
              widget.onSaved!(val!);
            },
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            onFieldSubmitted: (String term) {
              if (widget.nextFocusNode != null) {
                widget.focusNode!.unfocus();
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              } else {
                widget.submitAction!();
              }
            },
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              filled: true,
              fillColor: kPrimaryWhite,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: hintTextColor,
                  fontWeight: FontWeight.w400),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              border: border(context),
              enabledBorder: border(context),
              focusedBorder: focusBorder(context),
              errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Visibility(
          visible: error != null,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '$error',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  border(BuildContext context) {
    Color textFieldBorderColor = kPrimaryWhite;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: textFieldBorderColor,
        width: 0.0,
        style: BorderStyle.solid,
      ),
    );
  }

  focusBorder(BuildContext context) {
    Color textFieldBorderColor = kPrimaryWhite;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: textFieldBorderColor,
        width: 0.0,
        style: BorderStyle.solid,
      ),
    );
  }
}
