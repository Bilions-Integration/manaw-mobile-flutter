import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = Get.find<AuthController>();

  Map<String, dynamic> params = {
    "email": null,
    "password": null,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () {
          AppWidget.hideKeyboard();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.marginBottom(10),
                      Image.asset(AppAssets.appLogo),
                      AppWidget.marginBottom(2),
                      const Text(
                        'Manaw Store',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      AppWidget.marginBottom(1),
                      Text(
                        'All in one POS, Accounting, Invoices, Inventory software. Save your time & money.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightDark,
                        ),
                      ),
                      AppWidget.marginBottom(3),
                      MyTextInput(
                          onChanged: _onValueChanged,
                          column: 'email',
                          placeholder: 'Email',
                          icon: Icons.email),
                      AppWidget.marginBottom(2),
                      PasswordInput(
                          onChanged: _onValueChanged,
                          column: 'password',
                          placeholder: 'Password',
                          icon: Icons.lock),
                      AppWidget.marginBottom(2),
                      PrimaryButton(value: 'Login', onPressed: _login),
                      AppWidget.marginBottom(4),
                      InkWell(
                        child: const Text('Not a member yet? Register here'),
                        onTap: () {},
                      ),
                      AppWidget.marginBottom(10),
                      InkWell(
                        child: const Text('Powered by Bilions Co., Ltd'),
                        onTap: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onValueChanged(value, column) {
    setState(() {
      params[column] = value;
    });
  }

  _login() async {
    try {
      var res = await Api.post('/auth/login-email', data: params);
      if (res['status'] == 'success') {
        AppWidget.storeToken(res['token']);
        final user = User.fromJson(res['data']);
        auth.user.value = user;
        ARouter.push(RouteName.HOME);
      } else {
        _showError();
      }
    } catch (e) {
      _showError();
    }
  }

  _showError() {
    Get.snackbar('Error', 'Invalid email or password!',
        icon: const Icon(Icons.info));
  }
}
