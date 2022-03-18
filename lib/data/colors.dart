import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';

@immutable
class AppColors {
  const AppColors();
  static get darkRed => HexColor("#873e23");
  static get lightBlue => HexColor("#063970");

  static get dark {
    final authController = Get.find<AuthController>();
    return HexColor(authController.user.value?.company.hexColor ?? '#1A1A1A');
  }

  static get black => HexColor('#1A1A1A');
  static get blue => HexColor('#4C40F7');
  static get green => HexColor('#4ADB61');
  static get red => HexColor('#FF4D4D');
  static get lightDark => HexColor('#999999');
  static get borderColor => HexColor('#EEEEEE');
  static get white => HexColor('#FFFFFF');
  static get lightGrey => HexColor('#F3F3F3');
  static get line => HexColor('#BDBDBD');
  static get grey => HexColor('#7B7B7B');
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
