import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class MyTheme {
  init() {
    return ThemeData(
      fontFamily: 'ReadexPro',
      textTheme: const TextTheme(
        headline5: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          height: 1.5,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: 1.5,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: 1.5,
        ),
        overline: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.5,
          fontStyle: FontStyle.normal,
        ),
      ),
    ).copyWith(
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: AppColors.primary,
          ),
    );
  }
}
