import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/screens/forget_password/forget_password_screen.dart';
import 'package:my_app/screens/register/otp_screen.dart';
import 'package:my_app/screens/register/register_screen.dart';
import 'package:my_app/screens/tabs/tabs.dart';
import 'package:my_app/screens/tabs/dashboard/dashboard_screen.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/screens/tabs/management/manage_screen.dart';
import 'package:my_app/screens/tabs/pos/pos_screen.dart';
import 'package:my_app/screens/tabs/profile/profile_screen.dart';

class RouteName {
  static const pos = PosScreen();
  static const dashboard = DashboardScreen();
  static const manage = ManageScreen();
  static final profile = ProfileScreen();
  static const login = LoginScreen();
  static const register = RegisterScreen();
  static final home = TabsScreen();
  static const otp = OTPScreen();
  static const forgetPassword = ForgetPasswordScreen();
}

class ARouter {
  static void push(Widget screen) {
    Get.offAll(() => screen);
  }
}
