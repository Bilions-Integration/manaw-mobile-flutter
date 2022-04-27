import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/plan/plan_model.dart';

class PricingDetails {
  PlanModel plan;
  PricingDetails({required this.plan});

  void open() {
    final context = currentContext();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * (95 / 100),
            padding: MediaQuery.of(context).viewInsets,
            child: PricingDetail(
              plan: plan,
            ),
          );
        });
  }
}

class PricingDetail extends StatelessWidget {
  const PricingDetail({Key? key, required this.plan}) : super(key: key);
  final PlanModel plan;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.close),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              mb(0.5),
              Container(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.lightGrey,
                ),
                child: Column(
                  children: [
                    ...?plan.planDetails?.map((e) {
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
                                e,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )
      ],
    );
  }
}
