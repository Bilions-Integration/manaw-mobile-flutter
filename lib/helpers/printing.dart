import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';

printing({String? title}) async {
  await Future.delayed(const Duration(milliseconds: 50));
  final context = currentContext();
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Center(
      child: SizedBox(
        width: 300,
        child: Lottie.asset(
          AppAssets.lottiePrinting,
          repeat: true,
        ),
      ),
    ),
  );
}
