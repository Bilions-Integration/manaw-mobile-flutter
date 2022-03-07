import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/controllers/bottom_tab_controller.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/screens/after_auth_screen.dart';
import 'package:my_app/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final auth = Get.put(AuthController());
  final bottomTabController = Get.put(BottomTabController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColors.dark,
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
