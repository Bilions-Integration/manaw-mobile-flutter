import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/register/company_headline.dart';
import 'package:my_app/screens/register/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final auth = Get.find<AuthController>();
  final registerController = Get.put(RegisterController());

  Map<String, dynamic> params = {
    "email": null,
    "password": null,
    "full_name": null,
    "company_name": null,
    "referral_code": null,
  };

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
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      companyHeadline(),
                      AppWidget.marginBottom(3),
                      MyTextInput(
                        onChanged: _onValueChanged,
                        column: 'full_name',
                        placeholder: 'fullName'.tr,
                        icon: Icons.person,
                      ),
                      MyTextInput(
                        onChanged: _onValueChanged,
                        column: 'company_name',
                        placeholder: 'companyName'.tr,
                        icon: Icons.business,
                      ),
                      MyTextInput(
                        onChanged: _onValueChanged,
                        column: 'email',
                        placeholder: 'email'.tr,
                        icon: Icons.email,
                      ),
                      PasswordInput(
                        onChanged: _onValueChanged,
                        column: 'password',
                        placeholder: 'password'.tr,
                        icon: Icons.lock,
                      ),
                      MyTextInput(
                        onChanged: _onValueChanged,
                        column: 'referral_code',
                        placeholder: 'referralCodePlaceholder'.tr,
                        icon: Icons.groups,
                      ),
                      AppWidget.marginBottom(1),
                      PrimaryButton(
                        disabled: !_showRegister(),
                        value: 'register'.tr,
                        onPressed: _register,
                      ),
                      AppWidget.marginBottom(2),
                      InkWell(
                        child: Text('alreadyMember'.tr),
                        onTap: () {
                          ARouter.push(RouteName.login);
                        },
                      ),
                      AppWidget.marginBottom(5),
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

  _register() async {
    if (_showRegister() == false) {
      return;
    }
    try {
      RegisterParams paramsToSent = RegisterParams.fromJson(params);
      var res =
          await Api.post('/auth/register-email', data: paramsToSent.toJson());
      if (res['success']) {
        registerController.params.value = paramsToSent;
        Get.to(() => RouteName.otp);
      } else {
        alert(
          title: 'error'.tr,
          message: res['error'],
        );
      }
    } catch (e) {
      alert(
        title: 'error'.tr,
        message: 'somethingWrong'.tr,
      );
    }
  }

  bool _showRegister() {
    if (empty(params["email"]) ||
        empty(params["password"]) ||
        empty(params["full_name"]) ||
        empty(params["company_name"])) {
      return false;
    }
    return true;
  }
}
