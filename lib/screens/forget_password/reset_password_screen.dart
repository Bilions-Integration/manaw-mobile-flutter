import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/forget_password/forget_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final auth = Get.find<AuthController>();

  Map<String, dynamic> params = {
    "password_confirmation": null,
    "password": null,
  };

  bool _showLogin() {
    if (empty(params["password"]) || empty(params["password_confirmation"])) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Set New Password'),
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
                        'All in one POS, Accounting, Invoices, Inventory software. Save your time & money.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightDark,
                        ),
                      ),
                      AppWidget.marginBottom(3),
                      PasswordInput(
                        onChanged: _onValueChanged,
                        column: 'password',
                        placeholder: 'Password',
                        icon: Icons.lock,
                      ),
                      PasswordInput(
                        onChanged: _onValueChanged,
                        column: 'password_confirmation',
                        placeholder: 'Confirm',
                        icon: Icons.lock,
                      ),
                      AppWidget.marginBottom(1),
                      PrimaryButton(
                        value: 'Set New Password',
                        disabled: !_showLogin(),
                        onPressed: _resetPassword,
                      ),
                      AppWidget.marginBottom(9),
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

  _resetPassword() async {
    try {
      final forgetPasswordController = Get.find<ForgetPasswordController>();
      ForgetPasswordParams? paramsToSent =
          forgetPasswordController.params.value;

      if (paramsToSent != null) {
        paramsToSent.password = params["password"];
        paramsToSent.passwordConfirmation = params["password_confirmation"];
        final json = paramsToSent.toJson();
        var res = await Api.post('/auth/reset_password', data: json);
        if (res['success'] == true) {
          ARouter.push(RouteName.login);
        } else {
          _showError();
        }
      }
    } catch (e) {
      console.log(e);
      _showError();
    }
  }

  _showError() {
    Get.snackbar('Error', 'Something went wrong! Please try again.',
        icon: const Icon(Icons.info));
  }
}
