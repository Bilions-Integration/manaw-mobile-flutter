import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/firebase.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/routes.dart';
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
  AppUpdateInfo? _updateInfo;

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
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      _checkToken();
    });
    if (Platform.isAndroid) {
      _checkForUpdate();
    }
    super.initState();
  }

  Future<void> _checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
        if (_updateInfo?.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          InAppUpdate.startFlexibleUpdate();
          // InAppUpdate.performImmediateUpdate();
        }
      });
    }).catchError((e) {
      console.warn("Update check failed");
    });
  }

  _checkToken() async {
    try {
      // throw 'Auth Error';
      var res = await Api.get('/auth/refresh', showLoading: false);
      AppWidget.storeToken(res['token']);
      var res2 = await Api.get('/auth/user', showLoading: false);
      auth.user.value = User.fromJson(res2['data']);
      updateFirebaseToken();
      ARouter.push(RouteName.home);
    } catch (e) {
      ARouter.push(RouteName.login);
    }
  }
}
