// ignore_for_file: camel_case_types

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/current_context.dart';
import 'dart:core';

class console {
  static log(dynamic text, {dynamic payload}) {
    final fimber = FimberLog('');
    fimber.d('🔥🔥🔥 ===================');
    fimber.d(text.toString(), stacktrace: StackTrace.fromString(payload.toString()));
    fimber.d('END');
  }

  static warn(dynamic text, {dynamic payload}) {
    final fimber = FimberLog('');
    fimber.d(text);
    fimber.d('', ex: payload);
  }
}

BuildContext currentContext() {
  return CurrentContext.navigatorKey.currentContext!;
}

currency() {
  final auth = Get.find<AuthController>();
  return auth.user.value?.company.currency.toString() ?? '';
}

String cast(dynamic number) {
  if (number >= 1000) {
    var formatter = NumberFormat('#,##,000');
    return formatter.format(number);
  }
  return number.toString();
}

logo(double? width) {
  return Image.asset(
    AppAssets.appLogo,
    width: width ?? 60,
  );
}

hr() {
  return Padding(
    padding: const EdgeInsets.only(left: 3, right: 3),
    child: Container(
      height: 0,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line, width: 0.5)),
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
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

loading({String? title}) {
  final context = currentContext();
  showDialog(
    context: context,
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
      actionsPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
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

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
