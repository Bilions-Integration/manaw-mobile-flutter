import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/components/plan_card.dart';
import 'package:my_app/screens/plan/payment_service.dart';
import 'package:my_app/screens/plan/payment_type_screen.dart';
import 'package:my_app/screens/plan/plan_model.dart';

class PricingPreview extends StatefulWidget {
  final List<PlanModel> plans = [
    PlanModel(
        name: 'Silver',
        prices: {'monthly': 10000, 'yearly': 100000},
        currency: 'Ks',
        image: 'silver',
        color: AppColors.silver,
        isPopular: true,
        planDetails: [
          "2 Stores",
          "3 admins with different roles (staff, menu editor, admin)",
          "50 Coupon Codes",
          "Multiple Invoice PDF print",
          "15000 Invoice per month",
          "500 Products",
          "500 Customers",
          "500 Suppliers"
        ]),
    PlanModel(
        name: 'Gold',
        prices: {'monthly': 20000, 'yearly': 200000},
        currency: 'Ks',
        color: AppColors.gold,
        image: 'gold',
        planDetails: [
          "3 Stores",
          "50 admins with different roles (staff, menu editor, admin)",
          "Unlimited Coupon Codes",
          "Multiple Invoice PDF print",
          "Excel export for transactions",
          "Unlimited Invoices",
          "Unlimited Products",
          "Unlimited Customers",
          "Unlimited Suppliers"
        ]),
  ];

  PricingPreview({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PricingPreview();
}

class _PricingPreview extends State<PricingPreview> {
  String selectedTab = 'monthly';
  String selectedPlan = 'Silver';
  var paymentController = Get.put(PaymentController());
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
                            : FontWeight.normal,
                      ),
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
            padding: const EdgeInsets.all(15),
            child: PrimaryButton(
                value: 'Upgrade Now',
                onPressed: () => Get.to(const PaymentType()))),
        mb(0.5)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _changeTab(String type) {
    setState(() {
      selectedTab = type;
      paymentController.period.value = type;
    });
  }

  _onPlanSelect(String name) {
    setState(() {
      selectedPlan = name;
      paymentController.plan.value = name;
    });
  }
}
