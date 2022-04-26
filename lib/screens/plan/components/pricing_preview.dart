import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
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
            padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  child: Text(
                    "Monthly",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedTab == 'monthly'
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ),
                mr(1.6),
                InkWell(
                  onTap: () {
                    _changeTab('yearly');
                  },
                  child: Text(
                    'Yearly',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedTab == 'yearly'
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(15),
            children: <Widget>[
              ...widget.plans.map((e) {
                return InkWell(
                  onTap: () => _onPlanSelect(e.name),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      border: selectedPlan == e.name
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
                              AppAssets.getPlanIcon(e.image),
                              width: 45,
                            ),
                            mr(1),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name,
                                  style: TextStyle(
                                      color: e.color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(e.prices[selectedTab].toString() +
                                        ' ' +
                                        e.currency),
                                    mr(0.5),
                                    Text(
                                        '/' + selectedTab.capitalize.toString())
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
                  ),
                );
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
