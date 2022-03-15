import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/screens/tabs/management/category/manage_category.dart';
import 'package:my_app/screens/tabs/management/components/create_new_popup.dart';
import 'package:my_app/screens/tabs/management/components/current_plan.dart';
import 'package:my_app/screens/tabs/management/components/link_item.dart';
import 'package:my_app/screens/tabs/management/components/upgrade_plan.dart';
import 'package:my_app/screens/tabs/management/discount/manage_discount.dart';
import 'package:my_app/screens/tabs/management/invoice/manage_invoice.dart';
import 'package:my_app/screens/tabs/management/product/manage_product.dart';
import 'package:my_app/screens/tabs/management/report/manage_reports.dart';
import 'package:my_app/screens/tabs/management/store/manage_store.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({Key? key}) : super(key: key);

  static const List<Map> list = [
    {"name": "Products", "unit": "items", "count": 4, "page": ManageProduct()},
    {
      "name": "Categories",
      "unit": "categories",
      "count": 6,
      "page": ManageCategory()
    },
    {
      "name": "Discount",
      "unit": "invoice",
      "count": 2,
      "page": ManageDiscount()
    },
    {
      "name": "Purchase Invoices",
      "unit": "invoice",
      "count": 8,
      "page": ManageInvoice()
    },
    {
      "name": "Sale Invoices",
      "unit": "invoice",
      "count": 0,
      "page": ManageInvoice()
    },
    {"name": "Reports", "unit": "reports", "count": 8, "page": ManageReport()},
    {"name": "My Store", "unit": "", "count": 0, "page": ManageStore()},
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
                  for (var item in list.asMap().entries)
                    Stack(
                      children: <Widget>[
                        LinkItem(
                          name: item.value['name'],
                          count: item.value['count'],
                          unit: item.value['unit'],
                          page: item.value['page'],
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
