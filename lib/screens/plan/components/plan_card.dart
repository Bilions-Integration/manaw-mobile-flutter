import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/plan_model.dart';

class PlanCard extends StatelessWidget {
  const PlanCard(
      {Key? key,
      required this.plan,
      required this.selectedPlan,
      required this.selectedTab})
      : super(key: key);
  final String selectedPlan;
  final String selectedTab;
  final PlanModel plan;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      decoration: BoxDecoration(
        border: selectedPlan == plan.name
            ? Border.all(color: AppColors.dark, width: 3)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
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
            onTap: () {},
            child: const Text('Plan Details'),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
