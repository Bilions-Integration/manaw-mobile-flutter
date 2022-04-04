import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/screens/forget_password/forget_password_screen.dart';
import 'package:my_app/screens/forget_password/reset_password_screen.dart';
import 'package:my_app/screens/otp/otp_screen.dart';
import 'package:my_app/screens/printer_setting/printer_setting.dart';
import 'package:my_app/screens/register/register_screen.dart';
import 'package:my_app/screens/tabs/management/category/manage_category.dart';
import 'package:my_app/screens/tabs/management/invoice/manage_purchase_invoice.dart';
import 'package:my_app/screens/tabs/management/invoice/manage_sale_invoice.dart';
import 'package:my_app/screens/tabs/management/product/manage_product.dart';
import 'package:my_app/screens/tabs/management/report/manage_reports.dart';
import 'package:my_app/screens/tabs/management/store/manage_store.dart';
import 'package:my_app/screens/tabs/pos/checkout_screen.dart';
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
  static const profile = ProfileScreen();
  static const login = LoginScreen();
  static const register = RegisterScreen();
  static final home = TabsScreen();
  static const otp = OTPScreen();
  static const forgetPassword = ForgetPasswordScreen();
  static const resetPassword = ResetPasswordScreen();
  static const checkoutScreen = CheckoutScreen();
  static const printerSettingScreen = PrinterSettingScreen();
  static const category = ManageCategory();
  static const product = ManageProduct();
  static const purchaseInvoice = ManagePurchaseInvoice();
  static const saleInvoice = ManageSaleInvoice();
  static const report = ManageReport();
  static const myStore = ManageStore();
}

class ARouter {
  static void push(Widget screen) {
    Get.offAll(() => screen);
  }
}
