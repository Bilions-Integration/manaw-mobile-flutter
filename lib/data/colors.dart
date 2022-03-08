import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors();
  static get darkRed => HexColor("#873e23");
  static get lightBlue => HexColor("#063970");
  static get dark => HexColor('#1A1A1A');
  static get blue => HexColor('#4C40F7');
  static get green => HexColor('#4ADB61');
  static get red => HexColor('#FF4D4D');
  static get lightDark => HexColor('#999999');
  static get borderColor => HexColor('#EEEEEE');
  static get white => HexColor('#FFFFFF');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
