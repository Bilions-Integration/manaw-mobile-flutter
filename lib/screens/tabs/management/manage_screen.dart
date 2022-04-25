import 'package:flutter/material.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/management/components/create_new_popup.dart';
import 'package:my_app/screens/tabs/management/components/current_plan.dart';
import 'package:my_app/screens/tabs/management/components/link_item.dart';
import 'package:my_app/screens/tabs/management/components/upgrade_plan.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({Key? key}) : super(key: key);

  static List<ManagePage> pageList = [
    ManagePage(name: "Products", page: RouteName.product),
    ManagePage(name: "Categories", page: RouteName.category),
    ManagePage(name: "Sale Invoice", page: RouteName.saleInvoice),
    ManagePage(name: "Purchase Invoices", page: RouteName.purchaseInvoice),
    ManagePage(name: "Reports", page: RouteName.report),
    ManagePage(name: "My Store", page: RouteName.myStore),
    ManagePage(name: "Coupons", page: RouteName.coupon),
    ManagePage(name: "Accounts", page: RouteName.account),
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
                  ...pageList.map((e) {
                    return Stack(
                      children: <Widget>[
                        LinkItem(
                          name: e.name,
                          page: e.page,
                        ),
                        hr(),
                      ],
                    );
                  }),
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
