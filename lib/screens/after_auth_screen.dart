import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/components/bottom_tab.dart';
import 'package:my_app/components/index.dart';
import 'package:my_app/controllers/bottom_tab_controller.dart';
import 'package:my_app/routes.dart';

class AfterAuthScreen extends StatelessWidget {
  final bottomTabController = Get.find<BottomTabController>();

  final screens = [
    RouteName.POS,
    RouteName.DASHBOARD,
    RouteName.MANAGE,
    RouteName.PROFILE,
  ];

  AfterAuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AppWidget.hideKeyboard();
        },
        child: Scaffold(
            appBar: MyAppBar(),
            body: Obx(() => screens[bottomTabController.index.value]),
            bottomNavigationBar: const BottomTab()));
  }
}
