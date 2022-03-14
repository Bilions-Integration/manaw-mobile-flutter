import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/color_picker.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/screens/tabs/profile/profile_image.dart';
import 'package:my_app/screens/tabs/profile/profile_menu.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';
import 'package:my_app/services/company_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final auth = Get.find<AuthController>();
  final tab = Get.find<BottomTabsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ProfileImage(),
          Expanded(
            child: ListView(
              children: [
                Column(children: [
                  hr(),
                  ProfileMenu(icon: SvgPicture.asset(AppAssets.icUser), title: 'Name', value: auth.user.value!.name),
                  ProfileMenu(icon: SvgPicture.asset(AppAssets.icEmail), title: 'Email', value: auth.user.value!.email),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icTheme),
                    title: 'Appearance',
                    onPressed: _showColorPicker,
                  ),
                  ProfileMenu(icon: SvgPicture.asset(AppAssets.icKey), title: 'Password'),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icPrinter),
                    title: 'Printer Setting',
                    onPressed: () {
                      Get.to(RouteName.printerSettingScreen);
                    },
                  ),
                  ProfileMenu(icon: SvgPicture.asset(AppAssets.icHelp), title: 'Help'),
                  ProfileMenu(icon: SvgPicture.asset(AppAssets.icInfo), title: 'Report a problem'),
                  ProfileMenu(icon: SvgPicture.asset(AppAssets.bilions), title: 'About us', onPressed: _showAbout),
                  ProfileMenu(icon: SvgPicture.asset(AppAssets.icLogout), title: 'Logout', onPressed: _logout)
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showAbout() {
    showAboutDialog(
      context: currentContext(),
      applicationName: 'Manaw Store',
      applicationVersion: "1.0.0",
      applicationLegalese: 'All in one POS, Accounting, Invoices, Inventory software. Save your time & money.',
    );
  }

  _showColorPicker() {
    showColorPicker(onColorChange: (String color) {
      final user = auth.user.value;
      user?.company.hexColor = color;
      auth.user.value = user;
      tab.index.value = 0;
      tab.index.value = 3;
      CompanyService.setColor(color);
    });
  }

  _logout() {
    confirm(
      title: 'Logout',
      message: 'Are you sure to logout?',
      onPressed: (confirm) {
        if (confirm) {
          Future.delayed(const Duration(milliseconds: 500), () {
            auth.user.value = null;
            tab.index.value = 0;
            AppWidget.storeToken('');
            Get.offAll(() => const LoginScreen());
          });
        }
      },
    );
  }
}
