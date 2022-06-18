import 'package:flutter/cupertino.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';

Widget companyHeadline() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppWidget.marginBottom(4),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          logo(60),
          mr(1),
          Text(
            'Manaw Store',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      AppWidget.marginBottom(2),
      Text(
        'All in one POS, Accounting, Invoices, Inventory software. Save your time & money.',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.lightDark,
        ),
      ),
    ],
  );
}
