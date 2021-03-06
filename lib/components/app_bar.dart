import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/screens/tabs/management/components/create_new_popup.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final List<String> titles = <String>[
    'pos'.tr,
    'dashboard'.tr,
    'manage'.tr,
    'profile'.tr
  ];
  final bottomTabController = Get.find<BottomTabsController>();
  final authController = Get.find<AuthController>();

  MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        titleSpacing: 0,
        title: Text(
          titles[bottomTabController.index.value],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(AppAssets.appLogoSvg),
        ),
        centerTitle: false,
        backgroundColor: AppColors.primary,
        elevation: bottomTabController.index.value == 0 ||
                bottomTabController.index.value == 1
            ? 0
            : 0,
        actions: [
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            onTap: CreateNewPopup().open,
          ),
        ],
      ),
    );
  }
}
