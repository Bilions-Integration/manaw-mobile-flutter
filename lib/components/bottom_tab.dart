import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:my_app/controllers/bottom_tab_controller.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/data/assets.dart';
import 'package:get/get.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int index = 0;

  final bottomTabController = Get.find<BottomTabController>();

  void _onItemTapped(i) {
    setState(() {
      index = i;
    });
    bottomTabController.index.value = i;
  }

  _getColor(i) {
    return index == i ? AppColors.dark : AppColors.lightDark;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.pos,
              width: 20, height: 20, color: _getColor(0)),
          label: 'POS',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.dashboard,
              width: 20, height: 20, color: _getColor(1)),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.manage,
              width: 20, height: 20, color: _getColor(2)),
          label: 'Manage',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.profile,
              width: 20, height: 20, color: _getColor(3)),
          label: 'Profile',
        ),
      ],
      selectedItemColor: AppColors.dark,
      unselectedItemColor: AppColors.lightDark,
      onTap: _onItemTapped,
      currentIndex: index,
    );
  }
}
