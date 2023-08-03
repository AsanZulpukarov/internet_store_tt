import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black))),
    buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
        highlightColor: Colors.black,
        textTheme: ButtonTextTheme.primary),
    appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        color: AppColors.backgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        )),
  );
}
