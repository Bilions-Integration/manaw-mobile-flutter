import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/color_picker.dart';
import 'package:my_app/components/prompt.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/language/language_screen.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/screens/otp/otp_screen.dart';
import 'package:my_app/screens/tabs/profile/components/change_password_modal.dart';
import 'package:my_app/screens/tabs/profile/help_webview_screen.dart';
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
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImage(
            image: user?.image,
            callback: (User newUser) => {
              setState(() {
                user = newUser;
              })
            },
          ),
          mb(0.5),
          Expanded(
            child: ListView(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _label('profile'.tr),
                  ProfileMenu(
                    icon: AppAssets.icUser,
                    title: 'name'.tr,
                    value: user?.name ?? '',
                    onPressed: _changeName,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icEmail,
                    title: 'email'.tr,
                    value: user?.email ?? '',
                    onPressed: _changeEmail,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icKey,
                    title: 'password'.tr,
                    onPressed: _showChangePasswordModal,
                  ),
                  mb(1),
                  _label('preference'.tr),
                  ProfileMenu(
                    icon: AppAssets.icTheme,
                    title: 'appearance'.tr,
                    onPressed: _showColorPicker,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icHelp,
                    title: 'language'.tr,
                    onPressed: () => Get.to(() => const LanguageScreen()),
                  ),
                  if (Platform.isAndroid)
                    ProfileMenu(
                      icon: AppAssets.icPrinter,
                      title: 'printerSetting'.tr,
                      onPressed: () {
                        Get.to(RouteName.printerSettingScreen);
                      },
                    ),
                  mb(1),
                  _label('others'.tr),
                  ProfileMenu(
                    icon: AppAssets.icHelp,
                    title: 'help'.tr,
                    onPressed: () => Get.to(() => const HelpWebViewScreen()),
                  ),
                  ProfileMenu(
                    icon: AppAssets.icInfo,
                    title: 'reportProblem'.tr,
                    onPressed: _reportProblem,
                  ),
                  ProfileMenu(
                    icon: AppAssets.bilions,
                    title: 'aboutUs'.tr,
                    onPressed: _showAbout,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icLogout,
                    title: 'logout'.tr,
                    onPressed: _logout,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icDeactivate,
                    title: 'deleteAccount'.tr,
                    onPressed: _deactivate,
                    iconColor: AppColors.red,
                    textStyle: TextStyle(
                        color: AppColors.red, fontWeight: FontWeight.bold),
                  ),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      user = auth.user.value;
    });
    super.initState();
  }

  _changeEmail() {
    prompt(
      onSubmit: (String? email) async {
        if (email != null && email != '') {
          await ProfileService.requestChangeEmailOTP(email);
          Get.to(() => OTPScreen(type: 'change_email', email: email));
        }
      },
      confirmText: 'requestOtp'.tr,
      title: 'changeEmail'.tr,
      placeholder: 'enterEmailAddress'.tr,
      icon: Icons.email,
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
      confirmText: 'change'.tr,
      title: 'changeName'.tr,
      placeholder: 'enterFullName'.tr,
      icon: Icons.person,
    );
  }

  _deactivate() {
    prompt(
      onSubmit: (String? password) {
        if (password != null && password.toLowerCase() == 'yes') {
          loading();
          tab.index.value = 0;
          ProfileService.deactivate(password);
          Future.delayed(const Duration(milliseconds: 1000), () {
            hideLoading();
            Get.offAll(() => const LoginScreen());
            auth.user.value = null;
            AppWidget.storeToken('');
          });
        } else {
          Get.snackbar(
            'failed'.tr,
            'enterYesToDelete'.tr,
          );
        }
      },
      confirmText: 'delete'.tr,
      title: 'waringDeleteAccount'.tr,
      placeholder: 'Yes',
      iconWidget: Container(
        padding: const EdgeInsets.all(13),
        child: SvgPicture.asset(
          AppAssets.icDeactivate,
          color: AppColors.red,
        ),
      ),
    );
  }

  _label(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        hr(width: 1),
      ],
    );
  }

  _logout() {
    confirm(
      title: 'logout'.tr,
      message: 'logoutConfirm'.tr,
      onPressed: (confirm) {
        if (confirm) {
          loading();
          tab.index.value = 0;
          Future.delayed(const Duration(milliseconds: 1000), () {
            hideLoading();
            Get.offAll(() => const LoginScreen());
            auth.user.value = null;
            AppWidget.storeToken('');
          });
        }
      },
    );
  }

  _reportProblem() {
    prompt(
      onSubmit: _submitProblem,
      confirmText: 'submit'.tr,
      title: 'reportProblem'.tr,
      placeholder: 'helpPlaceholder'.tr,
      textarea: true,
      height: 310,
    );
  }

  _showAbout() {
    showAboutDialog(
      context: currentContext(),
      applicationName: 'Manaw Store',
      applicationVersion: "1.0.0",
      applicationLegalese: 'appDescription'.tr,
    );
  }

  _showChangePasswordModal() {
    changePassword();
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

  _submitProblem(String? message) async {
    var res = await Api.post('/reports', data: {'description': message ?? ''});
    if (res['success']) {
      snackBar("successTitle".tr, "successDesc".tr,
          icon: Icons.check_circle_outline_rounded);
    } else {
      snackBar("failTitle".tr, "failDesc".tr,
          icon: Icons.error_outline_rounded, color: Colors.red);
    }
  }
}
