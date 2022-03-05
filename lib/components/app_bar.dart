import 'package:flutter/material.dart';
import 'package:my_app/controllers/bottom_tab_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    Key? key,
  }) : super(key: key);

  final List<String> titles = <String>['POS', 'Dashboard', 'Manage', 'Profile'];

  final bottomTabController = Get.find<BottomTabController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        titleSpacing: 0,
        title: Obx(() => Text(
              titles[bottomTabController.index.value],
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(
            image: AssetImage(AppAssets.appLogo),
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppColors.darkRed);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
