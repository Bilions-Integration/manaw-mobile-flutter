import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/index.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: GestureDetector(
            onTap: () {
              AppWidget.hideKeyboard();
            },
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Text(auth.user.value?.email ?? '')),
                    Image.asset(AppAssets.appLogo),
                    AppWidget.marginBottom(5),
                    const TextInput(placeholder: 'Email', icon: Icons.email),
                    AppWidget.marginBottom(2),
                    const PasswordInput(
                        placeholder: 'Password', icon: Icons.lock),
                    AppWidget.marginBottom(2),
                    PrimaryButton(value: 'Login', onPressed: _login)
                  ],
                ),
              ),
            )));
  }

  _login() {
    print('logging in');
    ARouter.push(RouteName.HOME);
  }
}
