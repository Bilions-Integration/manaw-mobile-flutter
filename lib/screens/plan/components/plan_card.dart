import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/plan/components/pricing_details.dart';
import 'package:my_app/screens/plan/plan_model.dart';

class PlanCard extends StatelessWidget {
  final String selectedPlan;
  final String selectedTab;
  final PlanModel plan;
  const PlanCard(
      {Key? key,
      required this.plan,
      required this.selectedPlan,
      required this.selectedTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
          decoration: BoxDecoration(
            border: selectedPlan == plan.name
                ? Border.all(color: AppColors.primary, width: 3)
                : Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
            color: AppColors.lightGrey,
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Image.asset(
                    AppAssets.getPlanIcon(plan.image),
                    width: 45,
                  ),
                  mr(1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name,
                        style: TextStyle(
                            color: plan.color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(plan.prices[selectedTab].toString() +
                              ' ' +
                              plan.currency),
                          mr(0.5),
                          Text('/' + selectedTab.capitalize.toString())
                        ],
                      )
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  PricingDetails(plan: plan).open();
                },
                child: Text('planDetails'.tr),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        if (plan.isPopular) popularBlock(context),
      ],
    );
  }

  Widget popularBlock(BuildContext context) {
    return Positioned(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
        child: Text(
          'popular'.tr,
          style: Styles.t6Light,
        ),
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(9),
            bottomRight: Radius.circular(9),
          ),
        ),
      ),
      top: 0,
      left: MediaQuery.of(context).size.width / 2 - 30,
    );
  }
}
