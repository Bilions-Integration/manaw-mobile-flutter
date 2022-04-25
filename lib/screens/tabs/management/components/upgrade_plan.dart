import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/pricing_screen.dart';

class UpgradePlan extends StatelessWidget {
  const UpgradePlan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.7;
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor, width: 2),
              borderRadius: BorderRadius.circular(10)),
          padding:
              const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
          child: Row(
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(AppAssets.rocket),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: cWidth,
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: const [
                    Text(
                      'Upgrade',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Upgrade your account and get full access for your  business.',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            Get.to(() => const PricingScreen());
          },
          child: const Text(
            'Upgrade',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: AppColors.dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 46,
          minWidth: double.infinity,
        )
      ],
    );
  }
}
