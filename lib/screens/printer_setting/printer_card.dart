import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

Widget printerCard(printer, defaultPrinter, type, setPrinter) {
  return Card(
    elevation: 0,
    color: AppColors.lightGrey,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.borderColor, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.only(bottom: 6),
    child: InkWell(
      onTap: () {
        setPrinter(printer);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          SvgPicture.asset(
            AppAssets.icPrinter,
            width: 40,
          ),
          mr(1),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(printer.name ?? ''),
              Text(
                type,
                style: TextStyle(color: AppColors.lightDark),
              ),
            ],
          )),
          Icon(
            Icons.radio_button_checked,
            size: 20,
            color: defaultPrinter != printer.address
                ? AppColors.lightDark
                : AppColors.blue,
          )
        ]),
      ),
    ),
  );
}
