import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';

import 'helper.dart';

class Styles {
  //Normal text is same with t5
  static const TextStyle h1 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle h2 =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  static const TextStyle h3 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle h4 =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static const TextStyle h5 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const TextStyle h6 =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold);

  static TextStyle h1Light = TextStyle(
      color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle h2Light = TextStyle(
      color: AppColors.white, fontSize: 17, fontWeight: FontWeight.bold);
  static TextStyle h3Light = TextStyle(
      color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle h4Light = TextStyle(
      color: AppColors.white, fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle h5Light = TextStyle(
      color: AppColors.white, fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle h6Light = TextStyle(
      color: AppColors.white, fontSize: 13, fontWeight: FontWeight.bold);

  static const TextStyle t1 = TextStyle(fontSize: 18);
  static const TextStyle t2 = TextStyle(fontSize: 17);
  static const TextStyle t3 = TextStyle(fontSize: 16);
  static const TextStyle t4 = TextStyle(fontSize: 15);
  static const TextStyle t5 = TextStyle(fontSize: 14);
  static const TextStyle t6 = TextStyle(fontSize: 13);

  static TextStyle t1Light = TextStyle(color: AppColors.white, fontSize: 18);
  static TextStyle t2Light = TextStyle(color: AppColors.white, fontSize: 17);
  static TextStyle t3Light = TextStyle(color: AppColors.white, fontSize: 16);
  static TextStyle t4Light = TextStyle(color: AppColors.white, fontSize: 15);
  static TextStyle t5Light = TextStyle(color: AppColors.white, fontSize: 14);
  static TextStyle t6Light = TextStyle(color: AppColors.white, fontSize: 13);

  static const TextStyle l1 =
      TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 18);
  static const TextStyle l2 =
      TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 17);
  static const TextStyle l3 =
      TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 16);
  static const TextStyle l4 =
      TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 15);
  static const TextStyle l5 =
      TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 14);
  static const TextStyle l6 =
      TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 13);
  static const TextStyle label = TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5));
  static const TextStyle labelBold = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.bold);
  static const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);
  static const TextStyle normalText = TextStyle(fontSize: 14);

  static Widget loading = Center(
      child: RefreshProgressIndicator(
    color: AppColors.primary,
  ));

  static void customBottomSheet(
      BuildContext context, num height, Widget widget) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * (height / 100),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 30,
            top: 7,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 6,
                width: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              mb(1),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: widget,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget emptyList(
      {required String label,
      required String image,
      String? buttonLabel,
      FutureOr<dynamic> Function(dynamic)? afterCallback,
      dynamic link}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image),
          Text(label),
          mb(1.5),
          if (buttonLabel != null && link != null)
            SecondaryButton(
              value: buttonLabel,
              width: 220,
              onPressed: () => afterCallback != null
                  ? Get.to(link)?.then(afterCallback)
                  : Get.to(link),
            )
        ],
      ),
    );
  }

  static topOnlyBorderRadius(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }
}
