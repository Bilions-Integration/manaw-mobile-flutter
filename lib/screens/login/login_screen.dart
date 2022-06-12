import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/firebase.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/register/company_headline.dart';

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
    double width = MediaQuery.of(context).size.width;

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
            backgroundColor: AppColors.white,
            body: Stack(
              children: [
                Positioned(
                  bottom: -100,
                  left: -50,
                  child: SvgPicture.asset(
                    AppAssets.loginBelow,
                    color: HexColor('#519D51'),
                    width: width + 80,
                    height: 300,
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 50,
                  child: SvgPicture.asset(
                    AppAssets.icPoweredBy,
                    color: AppColors.white,
                  ),
                ),
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 430),
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppWidget.marginBottom(2),
                            companyHeadline(),
                            mb(4),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "login".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                            ),
                            mb(0.5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'loginLabel'.tr,
                                style: TextStyle(
                                  color: AppColors.lightDark,
                                ),
                              ),
                            ),
                            mb(1),
                            MyTextInput(
                              onChanged: _onValueChanged,
                              column: 'email',
                              placeholder: 'email'.tr,
                              iconWidget: Container(
                                padding: const EdgeInsets.all(13),
                                child: SvgPicture.asset(
                                  AppAssets.icEmail,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            PasswordInput(
                              onChanged: _onValueChanged,
                              column: 'password',
                              placeholder: 'password'.tr,
                              iconWidget: Container(
                                padding: const EdgeInsets.all(13),
                                child: SvgPicture.asset(
                                  AppAssets.icLock,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            AppWidget.marginBottom(1),
                            PrimaryButton(
                              value: 'doLogin'.tr,
                              disabled: false,
                              onPressed: () {
                                if (_showLogin()) {
                                  _login();
                                }
                              },
                            ),
                            AppWidget.marginBottom(2),
                            mb(2),
                            InkWell(
                              child: Text(
                                'notAMember'.tr,
                                style: TextStyle(
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              onTap: () {
                                Get.to(() => RouteName.register);
                              },
                            ),
                            AppWidget.marginBottom(2),
                            InkWell(
                              child: Text(
                                'forgetPassword'.tr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              onTap: () {
                                Get.to(() => RouteName.forgetPassword);
                              },
                            ),
                            AppWidget.marginBottom(7),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    try {
      var res = await Api.post('/auth/login-email', data: params);
      if (res['status'] == 'success') {
        AppWidget.storeToken(res['token']);
        final user = User.fromJson(res['data']);
        auth.user.value = user;
        updateFirebaseToken();
        ARouter.push(RouteName.home);
      } else {
        _showError();
      }
    } catch (e) {
      console.log(e.toString());
      _showError();
    }
  }

  _onValueChanged(value, column) {
    setState(() {
      params[column] = value;
    });
  }

  _showError() {
    snackBar('error'.tr, 'invalidCreds'.tr,
        icon: Icons.info, color: Colors.red);
  }

  bool _showLogin() {
    if (empty(params["email"]) || empty(params["password"])) {
      return false;
    }
    return true;
  }
}
