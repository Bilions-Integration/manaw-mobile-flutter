// ignore_for_file: camel_case_types
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/current_context.dart';

alert({String? title, String? message, Function()? onPressed}) {
  final context = currentContext();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Row(children: [
        const Icon(Icons.info),
        mr(1),
        Text(
          title ?? 'Info',
          style: TextStyle(color: AppColors.black, fontSize: 18),
        )
      ]),
      content: Text(
        message ?? '',
        style: TextStyle(color: AppColors.black, fontSize: 14),
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
                onPressed != null ? onPressed() : null;
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

Widget borderRadiusCard(
  double radius,
  child, {
  double border = 0,
  color,
  double padding = 0,
}) {
  return Container(
    child: child,
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.borderColor,
        width: border,
      ),
      color: color ?? AppColors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

String cast(dynamic input) {
  if (input.toString().isEmpty) {
    return '0';
  }
  String number = input.toString();
  num fixedNumber = num.parse(num.parse(number).toStringAsFixed(2));
  var formatter = NumberFormat('#,###,###.##');
  dynamic result = formatter.format(fixedNumber);
  return result.toString();
}

confirm({
  String? title,
  String? message,
  String? confirmText,
  String? cancelText,
  required Function(bool) onPressed,
}) {
  final context = currentContext();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actionsPadding: const EdgeInsets.all(10),
      contentPadding:
          const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      title: Row(children: [
        const Icon(Icons.info),
        mr(1),
        Text(
          title ?? 'info'.tr,
          style: TextStyle(color: AppColors.black, fontSize: 17),
        )
      ]),
      content: Text(
        message ?? '',
        style: TextStyle(color: AppColors.black, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => {onPressed(false), Navigator.pop(context)},
              child: Text(cancelText ?? 'cancel'.tr.toUpperCase(),
                  style: const TextStyle(fontSize: 13)),
            ),
            mr(3),
            PrimaryButton(
              value: confirmText ?? 'confirm'.tr.toUpperCase(),
              onPressed: () {
                Navigator.pop(context);
                onPressed(true);
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

currency() {
  final auth = Get.find<AuthController>();
  return auth.user.value?.company.currency.toString() ?? '';
}

BuildContext currentContext() {
  return CurrentContext.navigatorKey.currentContext!;
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

hideLoading({String? title}) {
  Navigator.pop(currentContext());
}

hr({double height = 0, double mt = 0, double mb = 0, double width = 2}) {
  return Container(
    margin: EdgeInsets.only(bottom: height, top: height),
    padding: EdgeInsets.only(left: 3, right: 3, top: mt * 10, bottom: mb * 10),
    child: Container(
      height: 0,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppColors.borderColor, width: width)),
      ),
    ),
  );
}

bool isFormValid(List<String> fieldNames, Map params) {
  bool isValid = true;
  for (var element in fieldNames) {
    if ([
      '',
      null,
      0,
    ].contains(params[element])) {
      isValid = false;
    }
  }
  return isValid;
}

loading({String? title}) async {
  await Future.delayed(const Duration(milliseconds: 50));
  final context = currentContext();
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => LoadingWidget(
      title: title,
    ),
  );
}

logo(double? width) {
  return SvgPicture.asset(
    AppAssets.appLogoSvg,
    width: width ?? 60,
  );
}

Widget logoText() {
  return const Text(
    'Manaw Store',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );
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

setTimeout(callback, {duration = 1000}) {
  Future.delayed(Duration(milliseconds: duration), callback);
}

SnackbarController snackBar(String title, String message,
    {IconData? icon, Color? color}) {
  return Get.snackbar(title, message,
      titleText: Text(
        title,
        style: TextStyle(color: color),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.7),
      animationDuration: const Duration(milliseconds: 830),
      barBlur: 18,
      icon: Icon(
        icon,
        color: color,
      ));
}

class console {
  static log(dynamic text, {dynamic payload = ''}) {
    var logger = Logger(printer: PrettyPrinter(colors: true, methodCount: 0));
    logger.d("${text.toString()} \n ${payload.toString()}");
  }

  static warn(dynamic text, {dynamic payload}) {
    final logger = Logger();
    logger.d(text.toString());
    logger.d(payload.toString());
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
