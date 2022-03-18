import 'package:flutter/material.dart';

class Styles {
  static topOnlyBorderRadius(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }
}
