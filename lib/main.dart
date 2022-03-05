import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/components/bottom_tab.dart';
import 'package:my_app/controllers/bottom_tab_controller.dart';
import 'package:my_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bottomTabController = Get.put(BottomTabController());

  final screens = [
    RouteName.POS,
    RouteName.DASHBOARD,
    RouteName.MANAGE,
    RouteName.PROFILE,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: const MyAppBar(),
          body: Obx(() => screens[bottomTabController.index.value]),
          bottomNavigationBar: const BottomTab()),
    );
  }
}
