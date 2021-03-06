import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/components/pricing_preview.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Image.asset(AppAssets.getPlanIcon('pricing-promo'))),
          Positioned(
            top: 25,
            right: 10,
            child: AppWidget.closeButton(context),
          ),
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "planHeadline".tr,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                mb(0.5),
                SizedBox(
                  width: 250,
                  child: Text(
                    'planDesc'.tr,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          mb(1),
          Positioned(left: 0, right: 0, bottom: 0, child: PricingPreview())
        ],
      ),
    );
  }
}
