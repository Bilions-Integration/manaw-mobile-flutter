import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/forget_password/forget_password_controller.dart';
import 'package:my_app/screens/otp/otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgetPasswordController = Get.put(ForgetPasswordController());

  Map<String, dynamic> params = {
    "email": null,
  };

  bool _showLogin() {
    if (empty(params["email"])) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Password Recover'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => {Get.back()},
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.marginBottom(8),
                      logo(60),
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
                        'Enter your email to reset password.',
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
                        icon: Icons.email,
                      ),
                      AppWidget.marginBottom(1),
                      PrimaryButton(
                        value: 'Recover',
                        disabled: !_showLogin(),
                        onPressed: _request,
                      ),
                      AppWidget.marginBottom(2),
                      InkWell(
                        child: const Text('Not a member yet? Register here'),
                        onTap: () {
                          Get.to(RouteName.register);
                        },
                      ),
                      AppWidget.marginBottom(2),
                      InkWell(
                        child: const Text(
                          'Back to login',
                          textAlign: TextAlign.left,
                        ),
                        onTap: () {
                          Get.to(RouteName.login);
                        },
                      ),
                      AppWidget.marginBottom(7),
                      SvgPicture.asset(AppAssets.icPoweredBy),
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

  _request() async {
    try {
      var res = await Api.post('/auth/request_reset_password', data: params);
      if (res['code'] == 404) {
        _showError();
      }
      if (res['code'] == 200) {
        forgetPasswordController.params.value =
            ForgetPasswordParams.fromJson(params);
        Get.to(() => const OTPScreen(type: 'forget_password'));
      }
    } catch (e) {
      _showError();
    }
  }

  _showError() {
    alert(
        title: 'Error',
        message: 'Account with ${params['email']} do not exist!');
  }
}
