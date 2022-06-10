import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int index = 0;

  List<String> titles = <String>[
    'pos'.tr,
    'dashboard'.tr,
    'manage'.tr,
    'profile'.tr
  ];
  List<NavItem> navItems = [
    NavItem(title: 'pos'.tr, icon: AppAssets.pos),
    NavItem(title: 'dashboard'.tr, icon: AppAssets.dashboard),
    NavItem(title: 'manage'.tr, icon: AppAssets.manage),
    NavItem(title: 'profile'.tr, icon: AppAssets.profile),
  ];

  final bottomTabController = Get.find<BottomTabsController>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        ...navItems
            .mapIndexed((NavItem item, int idx) => BottomNavigationBarItem(
                  icon: SvgPicture.asset(item.icon,
                      width: 20, height: 20, color: _getColor(idx)),
                  label: item.title,
                )),
      ],
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightDark,
      onTap: _onItemTapped,
      currentIndex: index,
      elevation: 1,
    );
  }

  _getColor(i) {
    return index == i ? AppColors.primary : AppColors.lightDark;
  }

  void _onItemTapped(i) {
    setState(() {
      index = i;
    });
    bottomTabController.index.value = i;
  }
}

class NavItem {
  String title;
  String icon;

  NavItem({required this.title, required this.icon});
}
