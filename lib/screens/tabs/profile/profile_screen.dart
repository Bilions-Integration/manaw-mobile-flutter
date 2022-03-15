import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/color_picker.dart';
import 'package:my_app/components/prompt.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/screens/otp/otp_screen.dart';
import 'package:my_app/screens/tabs/profile/profile_image.dart';
import 'package:my_app/screens/tabs/profile/profile_menu.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';
import 'package:my_app/services/company_service.dart';
import 'package:my_app/services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = Get.find<AuthController>();
  final tab = Get.find<BottomTabsController>();

  User? user;

  @override
  void initState() {
    setState(() {
      user = auth.user.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ProfileImage(
            image: user?.image,
            callback: (User newUser) => {
              setState(() {
                user = newUser;
              })
            },
          ),
          Expanded(
            child: ListView(
              children: [
                Column(children: [
                  hr(),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icUser),
                    title: 'Name',
                    value: user?.name ?? '',
                    onPressed: _changeName,
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icEmail),
                    title: 'Email',
                    value: user?.email ?? '',
                    onPressed: _changeEmail,
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icTheme),
                    title: 'Appearance',
                    onPressed: _showColorPicker,
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icKey),
                    title: 'Password',
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icPrinter),
                    title: 'Printer Setting',
                    onPressed: () {
                      Get.to(RouteName.printerSettingScreen);
                    },
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icHelp),
                    title: 'Help',
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icInfo),
                    title: 'Report a problem',
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.bilions),
                    title: 'About us',
                    onPressed: _showAbout,
                  ),
                  ProfileMenu(
                    icon: SvgPicture.asset(AppAssets.icLogout),
                    title: 'Logout',
                    onPressed: _logout,
                  )
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  _changeName() {
    prompt(
      onSubmit: (String? name) {
        if (name != null && name != '') {
          final User newUser = auth.user.value!;
          newUser.name = name;
          auth.user.value = newUser;
          setState(() {
            user = newUser;
          });
          ProfileService.setName(name);
        }
      },
      confirmText: 'Change',
      title: 'Change Name',
      placeholder: 'Enter your Full name',
      icon: Icons.person,
    );
  }

  _changeEmail() {
    prompt(
      onSubmit: (String? email) async {
        if (email != null && email != '') {
          await ProfileService.requestChangeEmailOTP(email);
          Get.to(() => OTPScreen(type: 'change_email', email: email));
        }
      },
      confirmText: 'Request',
      title: 'Change Email',
      placeholder: 'Enter new email address',
      icon: Icons.email,
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
