import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/components/plan_card.dart';
import 'package:my_app/screens/plan/plan_model.dart';

class PricingPreview extends StatefulWidget {
  PricingPreview({Key? key}) : super(key: key);

  final List<PlanModel> plans = [
    PlanModel(
        name: 'Silver',
        prices: {'monthly': 10000, 'yearly': 100000},
        currency: 'Ks',
        image: 'silver',
        color: AppColors.silver,
        isPopular: true),
    PlanModel(
        name: 'Gold',
        prices: {'monthly': 10000, 'yearly': 100000},
        currency: 'Ks',
        color: AppColors.gold,
        image: 'gold'),
  ];

  @override
  State<StatefulWidget> createState() => _PricingPreview();
}

class _PricingPreview extends State<PricingPreview> {
  String selectedTab = 'monthly';
  String selectedPlan = 'Silver';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.lightGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _changeTab('monthly');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 8),
                    child: Text(
                      "Monthly",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: selectedTab == 'monthly'
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _changeTab('yearly');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 8),
                    child: Text(
                      'Yearly',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: selectedTab == 'yearly'
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: <Widget>[
              ...widget.plans.map((e) {
                return InkWell(
                    onTap: () => _onPlanSelect(e.name),
                    child: PlanCard(
                        plan: e,
                        selectedPlan: selectedPlan,
                        selectedTab: selectedTab));
              })
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            value: 'Upgrade Now',
            onPressed: () {},
          ),
        )
      ],
    );
  }

  _onPlanSelect(String name) {
    setState(() {
      selectedPlan = name;
    });
  }

  _changeTab(String type) {
    setState(() {
      selectedTab = type;
    });
  }
}
