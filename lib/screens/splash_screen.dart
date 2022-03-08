import 'package:flutter/material.dart';
import 'package:my_app/components/index.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppAssets.appLogo),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Manaw Store',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        )
      ],
    )));
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      _checkToken();
    });
    super.initState();
  }

  _checkToken() async {
    try {
      var res = await Api.get('/auth/refresh');
      AppWidget.storeToken(res['token']);
      var res2 = await Api.get('/auth/user');
      auth.user.value = User.fromJson(res2['data']);
      ARouter.push(RouteName.HOME);
    } catch (e) {
      ARouter.push(RouteName.LOGIN);
    }
  }
}
