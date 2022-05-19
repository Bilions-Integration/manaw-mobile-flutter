import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/helpers/util_models.dart' as util;
import 'package:my_app/screens/tabs/management/category/create_edit_category.dart';
import 'package:my_app/screens/tabs/management/components/popup_item.dart';
import 'package:my_app/screens/tabs/management/coupon/coupon_create_and_edit.dart';
import 'package:my_app/screens/tabs/management/product/create_edit_product.dart';

class CreateNewPopup {
  CreateNewPopup();

  void open() {
    final context = currentContext();
    showModalBottomSheet(
        context: context,
        shape: Styles.topOnlyBorderRadius(15),
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.55,
            padding: MediaQuery.of(context).viewInsets,
            child: MyPopup(context: context),
          );
        });
  }
}

class MyPopup extends StatelessWidget {
  final BuildContext context;
  final List<util.PopupItem> popupItems = [
    util.PopupItem(
        icon: AppAssets.icProduct,
        name: "Product",
        onTap: () => {Get.to(() => const CreateProduct(type: 'create'))}),
    util.PopupItem(
        icon: AppAssets.icCategory,
        name: "Category",
        onTap: () => Get.to(() => const CreateCategory())),
    // util.PopupItem(
    //     icon: AppAssets.icInvoice,
    //     name: "Invoice",
    //     onTap: () => Get.to(() => const CreateInvoice())),
    util.PopupItem(
        icon: AppAssets.icDiscount,
        name: "Coupon",
        onTap: () => Get.to(() => const CouponCreateAndEdit())),
  ];

  MyPopup({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 7,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 6,
            width: 50,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 25),
            child: Text(
              "Create New",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 260,
            height: 300,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: popupItems.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        popupItems[index].onTap();
                      },
                      child: PopupItem(
                          icon: popupItems[index].icon,
                          name: popupItems[index].name));
                }),
          ),
        ],
      ),
    );
  }
}
