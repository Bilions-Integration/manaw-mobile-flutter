import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        titleSpacing: 0,
        title: const Text(
          'POS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
