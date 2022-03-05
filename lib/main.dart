import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/body.dart';
import 'package:my_app/components/colors.dart';
import 'package:my_app/data/assets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: const Text('Cool app'),
              centerTitle: false,
              backgroundColor: AppColors.darkRed),
          body: const BodyApp(),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images.svg',
                    width: 20, height: 20),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:
                    SvgPicture.asset(AppAssets.appLogo, width: 20, height: 20),
                label: 'Business',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'School',
              ),
            ],
            selectedItemColor: Colors.red[800],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
          ),
        ));
  }
}
