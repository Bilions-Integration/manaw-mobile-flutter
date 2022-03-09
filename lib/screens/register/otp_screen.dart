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
import 'package:my_app/screens/register/register_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final registerController = Get.find<RegisterController>();
  final authController = Get.find<AuthController>();

  String code = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
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
              length: 4,
              keyboardType: TextInputType.number,
              appContext: context,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  borderWidth: 1,
                  fieldWidth: width / 5,
                  inactiveFillColor: Colors.grey.withAlpha(30),
                  selectedFillColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedColor: AppColors.lightDark,
                  activeColor: AppColors.dark,
                  inactiveColor: Colors.grey.withAlpha(40)),
              backgroundColor: HexColor('#F6F6F6'),
              cursorColor: AppColors.dark,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onCompleted: (v) {
                _submit();
              },
              onChanged: (value) {
                setState(() {
                  code = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
            Expanded(child: mb(0)),
            PrimaryButton(
              value: 'NEXT',
              onPressed: () => {_submit()},
            ),
            mb(3),
          ],
        ),
      ),
    );
  }

  _submit() async {
    try {
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
          console.log(res.toString());
        }
      }
    } catch (e) {
      console.log(e.toString());
    }
  }
}
