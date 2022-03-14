import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/screens/tabs/management/components/current_plan.dart';
import 'package:my_app/screens/tabs/management/components/link_item.dart';
import 'package:my_app/screens/tabs/management/components/upgrade_plan.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({Key? key}) : super(key: key);

  static const List<Map> list = [
    {"name": "Products", "unit": "items", "count": 4},
    {"name": "Categories", "unit": "categories", "count": 6},
    {"name": "Discount", "unit": "invoice", "count": 2},
    {"name": "Purchase Invoices", "unit": "invoice", "count": 8},
    {"name": "Sale Invoices", "unit": "invoice", "count": 0},
    {"name": "Reports", "unit": "reports", "count": 8},
    {"name": "My Store", "unit": "", "count": 0},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          CurrentPlan(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: ListView(
                children: <Widget>[
                  for (var item in list.asMap().entries)
                    Stack(
                      children: <Widget>[
                        LinkItem(
                          name: item.value['name'],
                          count: item.value['count'],
                          unit: item.value['unit'],
                        ),
                        item.key != 0
                            ? Divider(
                                height: 2,
                                thickness: 2,
                                color: AppColors.borderColor,
                              )
                            : const SizedBox.shrink(),
                      ],
                    )
                ],
              ),
            ),
          ),
          const UpgradePlan(),
        ],
      ),
    ));
  }
}
