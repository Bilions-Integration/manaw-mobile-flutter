// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/current_context.dart';
import 'dart:core';

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

BuildContext currentContext() {
  return CurrentContext.navigatorKey.currentContext!;
}

currency() {
  final auth = Get.find<AuthController>();
  return auth.user.value?.company.currency.toString() ?? '';
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

logo(double? width) {
  return Image.asset(
    AppAssets.appLogo,
    width: width ?? 60,
  );
}

hr({double height = 0, double mt = 0, double mb = 0}) {
  return Container(
    margin: EdgeInsets.only(bottom: height, top: height),
    padding: EdgeInsets.only(left: 3, right: 3, top: mt * 10, bottom: mb * 10),
    child: Container(
      height: 0,
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: AppColors.borderColor, width: 2)),
      ),
    ),
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

Widget borderRadiusCard(radius, child, {double border = 0}) {
  return Container(
    child: child,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.borderColor, width: border),
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10),
    ),
  );
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

hideLoading({String? title}) {
  Navigator.pop(currentContext());
}

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
          title ?? 'Info',
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
              child: Text(cancelText ?? 'CANCEL',
                  style: const TextStyle(fontSize: 13)),
            ),
            mr(3),
            PrimaryButton(
              value: confirmText ?? 'CONFIRM',
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

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
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
