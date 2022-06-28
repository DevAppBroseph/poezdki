import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';

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
