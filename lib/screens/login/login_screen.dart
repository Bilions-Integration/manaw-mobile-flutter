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
import 'package:my_app/helpers/helper.dart';
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
      bottom: false,
      child: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 430),
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppWidget.marginBottom(7),
                        logo(80),
                        AppWidget.marginBottom(2),
                        Text(
                          'Manaw Store',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.darkBlue,
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
                        mb(3),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
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
                            'Enter your email to log in.',
                            style: TextStyle(
                              color: AppColors.lightDark,
                            ),
                          ),
                        ),
                        mb(1),
                        MyTextInput(
                          onChanged: _onValueChanged,
                          column: 'email',
                          placeholder: 'Email',
                          icon: Icons.email,
                        ),
                        PasswordInput(
                          onChanged: _onValueChanged,
                          column: 'password',
                          placeholder: 'Password',
                          icon: Icons.lock,
                        ),
                        AppWidget.marginBottom(1),
                        PrimaryButton(
                          value: 'Login',
                          disabled: !_showLogin(),
                          onPressed: () {
                            if (_showLogin()) {
                              _login();
                            } else {
                              Get.snackbar('New Message',
                                  'Required password and email.');
                            }
                          },
                        ),
                        AppWidget.marginBottom(2),
                        mb(2),
                        InkWell(
                          child: Text(
                            'Not a member yet? Register here',
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
                            'Forget password?',
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
                        SvgPicture.asset(AppAssets.icPoweredBy),
                      ],
                    )
                  ],
                ),
              ),
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
    snackBar('Error', 'Invalid email or password!',
        icon: Icons.info, color: Colors.red);
  }

  bool _showLogin() {
    if (empty(params["email"]) || empty(params["password"])) {
      return false;
    }
    return true;
  }
}
