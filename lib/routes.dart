import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_app/screens/after_auth_screen.dart';
import 'package:my_app/screens/dashboard_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/manage_screen.dart';
import 'package:my_app/screens/pos_screen.dart';
import 'package:my_app/screens/profile_screen.dart';

class RouteName {
  static const POS = PosScreen();
  static const DASHBOARD = DashboardScreen();
  static const MANAGE = ManageScreen();
  static final PROFILE = ProfileScreen();
  static const LOGIN = LoginScreen();
  static final HOME = AfterAuthScreen();
}

class ARouter {
  static void push(Widget screen) {
    Get.offAll(() => screen);
  }

  ARouter();
}
