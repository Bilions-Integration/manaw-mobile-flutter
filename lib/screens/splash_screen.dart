import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/after_auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Image(image: AssetImage(AppAssets.appLogo)),
        Padding(
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
      final box = GetStorage();
      final token = await box.read('@BearerToken');
      if (token == null) {
        ARouter.push(RouteName.LOGIN);
      }
      print(token);
    } catch (e) {
      print(e);
    }
  }
}
