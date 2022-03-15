import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/forget_password/forget_password_controller.dart';
import 'package:my_app/screens/register/register_controller.dart';
import 'package:my_app/services/profile_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String type;
  final String? email;
  const OTPScreen({Key? key, this.type = 'register', this.email}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final authController = Get.find<AuthController>();

  String code = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final length = widget.type == 'change_email' ? 6 : 4;
    final divide = widget.type == 'change_email' ? 7.5 : 5;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: const Text('Verify OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            setState(() {
              code = '';
            }),
            Get.back()
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
        child: Column(
          children: [
            logo(60),
            mb(2),
            logoText(),
            mb(2),
            const Text('Enter OTP which sent to your email!'),
            mb(2),
            PinCodeTextField(
              length: length,
              keyboardType: TextInputType.number,
              appContext: context,
              obscureText: false,
              enableActiveFill: true,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 60,
                borderWidth: 1,
                fieldWidth: width / divide,
                inactiveFillColor: Colors.grey.withAlpha(30),
                selectedFillColor: Colors.white,
                activeFillColor: Colors.white,
                selectedColor: AppColors.lightDark,
                activeColor: AppColors.dark,
                inactiveColor: Colors.grey.withAlpha(40),
              ),
              backgroundColor: HexColor('#F6F6F6'),
              cursorColor: AppColors.dark,
              animationDuration: const Duration(milliseconds: 300),
              onCompleted: (v) {
                _submit();
              },
              onChanged: (value) {
                setState(() {
                  code = value;
                });
              },
              beforeTextPaste: (text) {
                return false;
              },
            ),
            Expanded(child: mb(0)),
            PrimaryButton(
              value: 'Verify',
              onPressed: () => {_submit()},
            ),
            mb(3),
          ],
        ),
      ),
    );
  }

  _submit() async {
    if (code.isEmpty) {
      return false;
    }
    if (widget.type == 'register') {
      await _register();
    } else if (widget.type == 'forget_password') {
      await _passwordReset();
    } else {
      var res = await ProfileService.verifyChangeEmailOTP(widget.email, code);
      if (res) {
        Get.back();
      }
    }
  }

  _register() async {
    try {
      final registerController = Get.find<RegisterController>();
      RegisterParams? params = registerController.params.value;
      if (params != null) {
        params.code = code;
        console.log(params.toJson().toString());
        var res = await Api.post(
          '/auth/verify-email',
          data: params.toJson(),
        );
        if (res['status'] == 'success') {
          AppWidget.storeToken(res['token']);
          authController.user.value = User.fromJson(res['data']);
          ARouter.push(RouteName.home);
        } else {
          _showError();
          console.log(res.toString());
        }
      }
    } catch (e) {
      _showError();
      console.log(e.toString());
    }
  }

  _passwordReset() async {
    try {
      final forgetPasswordController = Get.find<ForgetPasswordController>();
      ForgetPasswordParams? paramsToSent = forgetPasswordController.params.value;
      if (paramsToSent != null) {
        paramsToSent.code = code;

        final newParams = paramsToSent.toJson();
        var res = await Api.post(
          '/auth/verify_reset_password',
          data: newParams,
        );
        if (res['success'] == true) {
          forgetPasswordController.params.value = ForgetPasswordParams.fromJson(newParams);
          Get.to(RouteName.resetPassword);
        } else {
          _showError();
          console.log(res.toString());
        }
      }
    } catch (e) {
      _showError();
      console.log(e.toString());
    }
  }

  _showError() {
    alert(title: 'Error', message: 'Invalid OTP');
  }
}
