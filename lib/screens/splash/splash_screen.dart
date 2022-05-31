import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/firebase.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

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
      body: UpgradeAlert(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo(100),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Manaw Store',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const Text(
                'Powered by Bilions Co., Ltd',
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      _checkToken();
    });
    var packageInfo = PackageInfo(
        appName: "MaNaw Store",
        packageName: "org.bilions.manawstore",
        version: '2.0.5',
        buildNumber: '11',
        buildSignature: '07B0C41ED9A5A1E81DDBBAC64FE559CE92BA3693');
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    console.log(
        'app_version =>>>>>>>>> ${packageInfo.appName}, ${packageInfo.version} ');
    //app_version =>>>>>>>>> 2.0.3, 07B0C41ED9A5A1E81DDBBAC64FE559CE92BA3693
    super.initState();
  }

  _checkToken() async {
    try {
      // throw 'Auth Error';
      var res = await Api.get('/auth/refresh');
      AppWidget.storeToken(res['token']);
      var res2 = await Api.get('/auth/user');
      auth.user.value = User.fromJson(res2['data']);
      updateFirebaseToken();
      ARouter.push(RouteName.home);
    } catch (e) {
      ARouter.push(RouteName.login);
    }
  }
}
