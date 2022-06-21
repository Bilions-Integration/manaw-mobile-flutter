import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/pricing_screen.dart';

class CurrentPlan extends StatelessWidget {
  final auth = Get.find<AuthController>();

  CurrentPlan({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
                AppAssets.getPlanIcon(auth.user.value?.plan.toString())),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xe8e8e8ff),
          ),
        ),
        mr(1),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (auth.user.value?.plan.capitalize.toString() ?? '') + ' Plan',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              if (![null, ''].contains(auth.user.value?.expiredDate))
                Text(
                  'expiredIn'
                      .trParams({'date': auth.user.value?.expiredDate ?? ''}),
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                )
            ],
          ),
        ),
        if (Platform.isAndroid)
          MaterialButton(
            elevation: 0,
            onPressed: () {
              Get.to(() => const PricingScreen());
            },
            child: Row(children: [
              SvgPicture.asset(
                AppAssets.icmRecharge,
                color: AppColors.white,
                width: 15,
              ),
              mr(0.4),
              Text(
                'recharge'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ]),
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 35,
          )
      ],
    );
  }
}
