import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/plan/payment_controller.dart';
import 'package:my_app/screens/plan/payment_method_screen.dart';
import 'package:my_app/screens/plan/plan_model.dart';

class PricingDetails {
  PlanModel plan;
  PricingDetails({required this.plan});

  void open() {
    final context = currentContext();
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        shape: Styles.topOnlyBorderRadius(15),
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.95,
            padding: MediaQuery.of(context).viewInsets,
            child: PricingDetail(
              plan: plan,
            ),
          );
        });
  }
}

class PricingDetail extends StatelessWidget {
  PricingDetail({Key? key, required this.plan}) : super(key: key);
  final PlanModel plan;
  final paymentController = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          right: 10,
          child: AppWidget.closeButton(context),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              mb(4),
              Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset(AppAssets.getPlanIcon(plan.image)),
                ),
              ),
              mb(0.5),
              Center(
                child: Text(
                  plan.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              mb(1.5),
              const Text(
                "Plan Details",
                style: Styles.h3,
              ),
              mb(0.5),
              Expanded(
                  child: ListView(
                children: [
                  DetailContainer(plan: plan),
                ],
              )),
              mb(1),
              pricingButton(
                plan: plan,
                type: 'yearly',
              ),
              mb(0.3),
              Center(
                child: Text(
                  'Save for 2 months',
                  style: TextStyle(color: AppColors.purple),
                ),
              ),
              mb(1.5),
              pricingButton(
                plan: plan,
                type: 'monthly',
              ),
              mb(1.5),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )
      ],
    );
  }

  Widget pricingButton({
    required PlanModel plan,
    required String type,
  }) {
    bool isYearly = type == 'yearly';

    return MaterialButton(
      onPressed: () {
        _submit(plan, type);
      },
      height: 50,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            plan.prices[type].toString() + ' ' + plan.currency,
            style: TextStyle(
              fontSize: Styles.h3.fontSize,
              fontWeight: Styles.h3.fontWeight,
              color: isYearly ? AppColors.white : AppColors.purple,
            ),
          ),
          Text(
            ' /' + type.capitalize.toString(),
            style: TextStyle(
              fontSize: Styles.t5.fontSize,
              color: isYearly ? AppColors.white : AppColors.purple,
            ),
          ),
        ],
      ),
      minWidth: double.infinity,
      color: isYearly ? AppColors.purple : AppColors.lightPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  _submit(PlanModel plan, String period) {
    paymentController.plan.value = plan.name;
    paymentController.period.value = period;
    paymentController.total.value = plan.prices[period]!;
    Get.to(const PaymentMethodScreen());
  }
}

class DetailContainer extends StatelessWidget {
  final PlanModel plan;
  const DetailContainer({required this.plan, Key? key}) : super(key: key);

  Widget detailItem(String label) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 15,
        right: 15,
      ),
      child: Row(
        children: [
          Image.asset(
            AppAssets.getPlanIcon('mark'),
            width: 22,
          ),
          mr(1),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.lightGrey,
      ),
      child: Column(
        children: [...plan.planDetails.map((e) => detailItem(e))],
      ),
    );
  }
}

/*
Payment methods
{
    "plan" : "gold",
    "period" : "monthly",
    "payment_channel": [
        "CC"
        "KBZQR"
        "CBPQR"
        "MPU"
        "ALL"
    ]
}
 */
