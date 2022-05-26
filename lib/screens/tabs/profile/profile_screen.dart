import 'package:flutter/material.dart';
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
                  _label('Profile'),
                  ProfileMenu(
                    icon: AppAssets.icUser,
                    title: 'Name',
                    value: user?.name ?? '',
                    onPressed: _changeName,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icEmail,
                    title: 'Email',
                    value: user?.email ?? '',
                    onPressed: _changeEmail,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icKey,
                    title: 'Password',
                    onPressed: _showChangePasswordModal,
                  ),
                  mb(1),
                  _label('Preference'),
                  ProfileMenu(
                    icon: AppAssets.icTheme,
                    title: 'Appearance',
                    onPressed: _showColorPicker,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icPrinter,
                    title: 'Printer Setting',
                    onPressed: () {
                      Get.to(RouteName.printerSettingScreen);
                    },
                  ),
                  mb(1),
                  _label('Others'),
                  ProfileMenu(
                    icon: AppAssets.icHelp,
                    title: 'Help',
                    onPressed: () => Get.to(() => const HelpWebViewScreen()),
                  ),
                  ProfileMenu(
                    icon: AppAssets.icInfo,
                    title: 'Report a problem',
                    onPressed: _reportProblem,
                  ),
                  ProfileMenu(
                    icon: AppAssets.bilions,
                    title: 'About us',
                    onPressed: _showAbout,
                  ),
                  ProfileMenu(
                    icon: AppAssets.icLogout,
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
      confirmText: 'Request OTP',
      title: 'Change Email',
      placeholder: 'Enter new email address',
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
      confirmText: 'Change',
      title: 'Change Name',
      placeholder: 'Enter your Full name',
      icon: Icons.person,
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
      title: 'Logout',
      message: 'Are you sure to logout?',
      onPressed: (confirm) {
        if (confirm) {
          loading();
          tab.index.value = 0;
          Future.delayed(const Duration(milliseconds: 1000), () {
            hideLoading();
            Get.offAll(() => const LoginScreen());
            AppWidget.storeToken('');
          });
        }
      },
    );
  }

  _reportProblem() {
    prompt(
      onSubmit: _submitProblem,
      confirmText: 'Submit',
      title: 'Report',
      placeholder: 'Write a message',
      textarea: true,
      height: 300,
    );
  }

  _showAbout() {
    showAboutDialog(
      context: currentContext(),
      applicationName: 'Manaw Store',
      applicationVersion: "1.0.0",
      applicationLegalese:
          'All in one POS, Accounting, Invoices, Inventory software. Save your time & money.',
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

  _submitProblem(String? name) async {
    //TODO : request api route for this
    var res = await Api.post('/platform/helps',
        data: {'description': name ?? ''}, formData: true);
    if (res['success']) {
      Get.snackbar(
        'Success',
        'Thanks for your feedback.',
        icon: const Icon(Icons.check_circle),
      );
    } else {
      Get.snackbar(
        'Failed',
        'Please try again.',
        icon: const Icon(Icons.check_circle),
      );
    }
  }
}
