import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';
import 'package:my_app/routes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final auth = Get.find<AuthController>();
  final tab = Get.find<BottomTabsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(currency()),
          PrimaryButton(value: 'Logout', onPressed: _logout),
        ],
      ),
    );
  }

  _logout() {
    auth.user.value = null;
    tab.index.value = 0;
    AppWidget.storeToken('');
    ARouter.push(RouteName.login);
  }
}
