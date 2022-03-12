import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/screens/tabs/profile/profile_image.dart';
import 'package:my_app/screens/tabs/profile/profile_menu.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';

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
            child: Column(children: [
              ProfileMenu(icon: SvgPicture.asset(AppAssets.icEmail), title: 'Email', value: auth.user.value!.email),
              ProfileMenu(icon: SvgPicture.asset(AppAssets.icTheme), title: 'Appearance'),
              ProfileMenu(icon: SvgPicture.asset(AppAssets.icKey), title: 'Password'),
              ProfileMenu(icon: SvgPicture.asset(AppAssets.icHelp), title: 'Help'),
              ProfileMenu(icon: SvgPicture.asset(AppAssets.icInfo), title: 'Report a problem'),
              ProfileMenu(icon: SvgPicture.asset(AppAssets.bilions), title: 'About us'),
              ProfileMenu(
                icon: const Icon(Icons.logout),
                title: 'Logout',
                onPressed: _logout,
              )
            ]),
          ),
        ],
      ),
    );
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
