import 'package:flutter/material.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/management/components/create_new_popup.dart';
import 'package:my_app/screens/tabs/management/components/current_plan.dart';
import 'package:my_app/screens/tabs/management/components/link_item.dart';
import 'package:my_app/screens/tabs/management/components/upgrade_plan.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({Key? key}) : super(key: key);

  static const List<Map> list = [
    {"name": "Products", "page": RouteName.product},
    {"name": "Categories", "page": RouteName.category},
    {"name": "Sale Invoices", "page": RouteName.saleInvoice},
    {"name": "Purchase Invoices", "page": RouteName.purchaseInvoice},
    {"name": "Reports", "page": RouteName.report},
    {"name": "My Store", "page": RouteName.myStore},
  ];

  static void openCreatePopup() {
    CreateNewPopup().open();
  }

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
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListView(
                children: <Widget>[
                  mb(2),
                  for (var item in list.asMap().entries)
                    Stack(
                      children: <Widget>[
                        LinkItem(
                          name: item.value['name'],
                          page: item.value['page'],
                        ),
                        hr(),
                      ],
                    ),
                  hr()
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
