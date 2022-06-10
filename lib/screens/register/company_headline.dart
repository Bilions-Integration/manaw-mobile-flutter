import 'package:flutter/cupertino.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';

Widget companyHeadline() {
  return Column(
    children: [
      AppWidget.marginBottom(4),
      logo(60),
      AppWidget.marginBottom(2),
      const Text(
        'Manaw Store',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      AppWidget.marginBottom(1),
      Text(
        'All in one POS, Accounting, Invoices, Inventory software. Save your time & money.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.lightDark,
        ),
      ),
    ],
  );
}
