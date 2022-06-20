import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/management/components/create_new_popup.dart';
import 'package:my_app/screens/tabs/management/components/current_plan.dart';
import 'package:my_app/screens/tabs/management/components/link_item.dart';

class ManageScreen extends StatelessWidget {
  static List<ManagePage> pageList = [
    ManagePage(
      name: "products",
      page: RouteName.product,
      icon: AppAssets.icmProduct,
    ),
    ManagePage(
      name: "categories",
      page: RouteName.category,
      icon: AppAssets.icmCategory,
    ),
    ManagePage(
      name: "saleInvoices",
      page: RouteName.saleInvoice,
      icon: AppAssets.icmSaleInvoice,
    ),
    ManagePage(
      name: "purchaseInvoices",
      page: RouteName.purchaseInvoice,
      icon: AppAssets.icmPurchaseInvoice,
    ),
    ManagePage(
      name: "inventoryReports",
      page: RouteName.report,
      icon: AppAssets.icmReport,
    ),
    ManagePage(
      name: "myStore",
      page: RouteName.myStore,
      icon: AppAssets.icmStore,
    ),
    ManagePage(
      name: "coupons",
      page: RouteName.coupon,
      icon: AppAssets.icCoupon,
    ),
    ManagePage(
      name: "accounts",
      page: RouteName.account,
      icon: AppAssets.icAccount,
    ),
    ManagePage(
      name: "referral",
      page: RouteName.referral,
      icon: AppAssets.icReferral,
    ),
  ];

  const ManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: <Widget>[
                  if (Platform.isAndroid) mb(1),
                  if (Platform.isAndroid) CurrentPlan(),
                  if (Platform.isAndroid) mb(1),
                  ...pageList.mapIndexed(
                    (e, i) {
                      return Stack(
                        children: <Widget>[
                          LinkItem(
                            name: e.name,
                            page: e.page,
                            icon: e.icon,
                          ),
                          hr(width: 1),
                        ],
                      );
                    },
                  ),
                  hr(width: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void openCreatePopup() {
    CreateNewPopup().open();
  }
}
