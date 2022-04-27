import 'package:flutter/material.dart';
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
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              mb(1),
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
              mb(1),
              Expanded(
                child: PricingPreview(),
              )
            ],
          ),
          Positioned(
            top: 25,
            right: 10,
            child: AppWidget.closeButton(context),
          ),
        ],
      ),
    );
  }
}
