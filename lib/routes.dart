import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_app/screens/tabs/tabs.dart';
import 'package:my_app/screens/tabs/dashboard/dashboard_screen.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/screens/tabs/management/manage_screen.dart';
import 'package:my_app/screens/tabs/pos/pos_screen.dart';
import 'package:my_app/screens/tabs/profile/profile_screen.dart';

class RouteName {
  static const POS = PosScreen();
  static const DASHBOARD = DashboardScreen();
  static const MANAGE = ManageScreen();
  static final PROFILE = ProfileScreen();
  static const LOGIN = LoginScreen();
  static final HOME = TabsScreen();
}

class ARouter {
  static void push(Widget screen) {
    Get.offAll(() => screen);
  }

  ARouter();
}
