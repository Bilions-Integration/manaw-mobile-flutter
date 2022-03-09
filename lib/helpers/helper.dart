// ignore_for_file: camel_case_types

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';

class console {
  static log(dynamic text, {dynamic payload}) {
    final fimber = FimberLog('LOG');
    fimber.d(text, ex: payload);
  }
}

logo(double? width) {
  return Image.asset(
    AppAssets.appLogo,
    width: width ?? 60,
  );
}

empty(String? value) {
  if (value == null || value.isEmpty) {
    return true;
  }
  return false;
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Widget mb(double value) {
  return Padding(padding: EdgeInsets.only(bottom: value * 10));
}

Widget mr(double value) {
  return Padding(padding: EdgeInsets.only(right: value * 10));
}

Widget p(double padding, Widget child) {
  return Padding(padding: EdgeInsets.all(padding), child: child);
}

Widget borderRadiusCard(radius, child) {
  return Container(
    child: child,
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

alert({required BuildContext context, String? title, String? message}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Row(children: [
        const Icon(Icons.info),
        mr(1),
        Text(
          title ?? 'Info',
          style: TextStyle(color: AppColors.dark, fontSize: 18),
        )
      ]),
      content: Text(
        message ?? '',
        style: TextStyle(color: AppColors.dark, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              value: 'Ok',
              onPressed: () {
                Navigator.pop(context);
              },
              width: 100,
              height: 40,
            )
          ],
        ),
      ],
    ),
  );
}

confirm({
  required BuildContext context,
  String? title,
  String? message,
  String? confirmText,
  String? cancelText,
  required Function(bool) onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      actionsPadding: const EdgeInsets.all(10),
      contentPadding:
          const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      title: Row(children: [
        const Icon(Icons.info),
        mr(1),
        Text(
          title ?? 'Info',
          style: TextStyle(color: AppColors.dark, fontSize: 18),
        )
      ]),
      content: Text(
        message ?? '',
        style: TextStyle(color: AppColors.dark, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => {onPressed(false), Navigator.pop(context)},
              child: Text(cancelText ?? 'Cancel'),
            ),
            mr(3),
            PrimaryButton(
              value: confirmText ?? 'Confirm',
              onPressed: () {
                onPressed(true);
                Navigator.pop(context);
              },
              width: 100,
              height: 40,
            )
          ],
        ),
      ],
    ),
  );
}
