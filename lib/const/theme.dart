import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  primarySwatch: MaterialColor(0xFF22bb9c, kPrimaryMaterialColor),
);

final defaultPinTheme = PinTheme(
  width: 77,
  height: 50,
  textStyle: const TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(30, 60, 87, 1),
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    color: const Color.fromRGBO(249, 249, 249, 1),
    borderRadius: BorderRadius.circular(10),
  ),
);

final focusedPinTheme = PinTheme(
  width: 77,
  height: 50,
  textStyle: const TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(30, 60, 87, 1),
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(10),
  ),
);

const submittedPinTheme = PinTheme(
  width: 77,
  height: 50,
  textStyle: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    color: Color.fromRGBO(234, 239, 243, 1),
  ),
);
