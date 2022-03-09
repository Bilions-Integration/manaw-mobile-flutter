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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final auth = Get.find<AuthController>();

  Map<String, dynamic> params = {
    "email": null,
    "password": null,
    "name": null,
    "company_name": null,
  };

  bool _showRegister() {
    if (empty(params["email"]) ||
        empty(params["password"]) ||
        empty(params["name"]) ||
        empty(params["company_name"])) {
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
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.marginBottom(4),
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
                      MyTextInput(
                        onChanged: _onValueChanged,
                        column: 'name',
                        placeholder: 'Name',
                        icon: Icons.person,
                      ),
                      MyTextInput(
                        onChanged: _onValueChanged,
                        column: 'company_name',
                        placeholder: 'Store / Company Name',
                        icon: Icons.business,
                      ),
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
                        disabled: !_showRegister(),
                        value: 'Register',
                        onPressed: _register,
                      ),
                      AppWidget.marginBottom(2),
                      InkWell(
                        child: const Text('Already member? Login here'),
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
      _showError();
    }
  }

  _showError() {
    Get.snackbar('Error', 'Something went wrong! Please try again.',
        icon: const Icon(Icons.info));
  }
}
