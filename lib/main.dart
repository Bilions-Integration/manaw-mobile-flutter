import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/helpers/current_context.dart';
import 'package:my_app/screens/tabs/tabs_controller.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/screens/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
  final cart = Get.put(CartController());
  final bottomTabController = Get.put(BottomTabsController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
              textTheme: GoogleFonts.readexProTextTheme(),
              checkboxTheme: CheckboxThemeData(
                  checkColor: MaterialStateProperty.all(AppColors.white),
                  fillColor: MaterialStateProperty.all(AppColors.dark)))
          .copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppColors.dark,
            ),
      ),
      navigatorKey: CurrentContext.navigatorKey,
      key: CurrentContext.scaffoldKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
