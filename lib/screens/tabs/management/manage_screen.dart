import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      name: "products".tr,
      page: RouteName.product,
      icon: AppAssets.icmProduct,
    ),
    ManagePage(
      name: "categories".tr,
      page: RouteName.category,
      icon: AppAssets.icmCategory,
    ),
    ManagePage(
      name: "saleInvoices".tr,
      page: RouteName.saleInvoice,
      icon: AppAssets.icmSaleInvoice,
    ),
    ManagePage(
      name: "purchaseInvoices".tr,
      page: RouteName.purchaseInvoice,
      icon: AppAssets.icmPurchaseInvoice,
    ),
    ManagePage(
      name: "inventoryReports".tr,
      page: RouteName.report,
      icon: AppAssets.icmReport,
    ),
    ManagePage(
      name: "myStore".tr,
      page: RouteName.myStore,
      icon: AppAssets.icmStore,
    ),
    ManagePage(
      name: "coupons".tr,
      page: RouteName.coupon,
      icon: AppAssets.icCoupon,
    ),
    ManagePage(
      name: "accounts".tr,
      page: RouteName.account,
      icon: AppAssets.icAccount,
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
