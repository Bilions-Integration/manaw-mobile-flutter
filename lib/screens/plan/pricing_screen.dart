import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              mb(3),
              Image.asset(AppAssets.getPlanIcon('pricing-promo')),
              const Text(
                "Best plans for your business",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              mb(0.5),
              const SizedBox(
                width: 250,
                child: Text(
                  'Upgrade your account and get full access for your business',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Positioned(
            top: 25,
            right: 10,
            child: FloatingActionButton.small(
              onPressed: () {
                Get.back();
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.black,
              child: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
