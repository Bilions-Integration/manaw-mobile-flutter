import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/components/bottom_tab.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/language/locale_helper.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';

class TabsScreen extends StatelessWidget {
  final bottomTabController = Get.find<BottomTabsController>();
  final langController = Get.find<LanguageController>();

  final screens = [
    RouteName.pos,
    RouteName.dashboard,
    RouteName.manage,
    RouteName.profile,
  ];

  TabsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        appBar: MyAppBar(),
        body: Obx(() => screens[bottomTabController.index.value]),
        bottomNavigationBar: BottomTab(
          key: Key(langController.locale.value.languageCode),
        ),
      ),
    );
  }
}
