import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';

class CurrentPlan extends StatelessWidget {
  CurrentPlan({
    Key? key,
  }) : super(key: key);

  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(AppAssets.bronzeIcon),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xe8e8e8ff),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (auth.user.value?.plan.capitalize.toString() ?? '') + ' Plan',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                'Expired in ' + (auth.user.value?.expiredDate ?? ''),
                style: const TextStyle(
                  color: Colors.black45,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
