import 'package:flutter/material.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    Key? key,
  }) : super(key: key);

  final List<String> titles = <String>['POS', 'Dashboard', 'Manage', 'Profile'];

  final bottomTabController = Get.find<BottomTabsController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Obx(
        () => Text(
          titles[bottomTabController.index.value],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset(AppAssets.appLogo),
      ),
      centerTitle: false,
      backgroundColor: AppColors.dark,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
