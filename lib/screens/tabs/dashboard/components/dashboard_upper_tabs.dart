import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/screens/tabs/dashboard/components/badge.dart';

class DashboardUpperTabs extends StatefulWidget {
  final Function(int) screenChanged;
  const DashboardUpperTabs({Key? key, required this.screenChanged})
      : super(key: key);

  @override
  State<DashboardUpperTabs> createState() => _DashboardUpperTabsState();
}

class _DashboardUpperTabsState extends State<DashboardUpperTabs> {
  var currentScreen = 0;

  final List screens = [
    {'title': 'overview'.tr, 'key': 0},
    {'title': 'summary'.tr, 'key': 1},
    {'title': 'topProducts'.tr, 'key': 2},
    {'title': 'topCustomers'.tr, 'key': 3},
  ];

  _changeScreen(screen) {
    setState(() {
      currentScreen = screen['key'];
    });
    widget.screenChanged(currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.0,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: screens
            .map(
              (screen) => Badge(
                title: screen['title'],
                active: screen['key'] == currentScreen,
                onPressed: () {
                  _changeScreen(screen);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
