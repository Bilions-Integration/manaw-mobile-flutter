import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class MyTheme {
  init() {
    double lineHeight = 1.5;
    return ThemeData(
      fontFamily: 'ReadexPro',
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          height: lineHeight,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          height: lineHeight,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.25,
          height: lineHeight,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.15,
          height: lineHeight,
        ),
        subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: lineHeight,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: lineHeight,
        ),
        overline: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: lineHeight,
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
