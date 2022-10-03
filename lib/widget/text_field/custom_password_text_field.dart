// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class KPasswordField extends StatefulWidget {
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
  final void Function(String)? onSaved, onChange;
  final Key? fieldKey;
  final IconData? prefix;
  final IconData? suffix;

  const KPasswordField(
      {this.prefix,
      this.suffix,
      this.initialValue,
      this.enabled,
      this.hintText,
      this.textInputType,
      required this.controller,
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
  KPasswordFieldState createState() => KPasswordFieldState();
}

class KPasswordFieldState extends State<KPasswordField> {
  String? error;
  bool obscureText = true;
  Color hintTextColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    const secondaryColor = kPrimaryColor2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 75,
          width: widthOfScreen,
          child: TextFormField(
            initialValue: widget.initialValue,
            enabled: widget.enabled,
            // onChanged: (val) {
            //   error = widget.validateFunction!(val);
            //   setState(() {});
            //   widget.onSaved!(val);
            // },
            key: widget.fieldKey,
            controller: widget.controller,
            // obscureText: widget.obscureText,
            obscureText: obscureText,
            keyboardType: widget.textInputType,
            validator: widget.validateFunction,
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
              prefixIcon: widget.prefix != null
                  ? Icon(
                      widget.prefix,
                      size: 15.0,
                      color: secondaryColor,
                    )
                  : null,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() => obscureText = !obscureText);
                },
                child: Icon(
                  obscureText
                      ? MaterialCommunityIcons.eye_off_outline
                      : MaterialCommunityIcons.eye_outline,
                  color: Colors.grey,
                  size: 30.0,
                ),
              ),
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
              errorStyle: const TextStyle(height: 0.0, fontSize: 10.0),
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
