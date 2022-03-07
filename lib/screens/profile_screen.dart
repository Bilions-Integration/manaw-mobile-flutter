import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/controllers/bottom_tab_controller.dart';
import 'package:my_app/routes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final auth = Get.find<AuthController>();
  final tab = Get.find<BottomTabController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          PrimaryButton(value: 'Logout', onPressed: _logout),
        ],
      ),
    );
  }

  _logout() {
    auth.user.value = null;
    tab.index.value = 0;
    ARouter.push(RouteName.LOGIN);
  }
}
