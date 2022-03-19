import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/category/create_edit_category.dart';
import 'package:my_app/screens/tabs/management/discount/create_edit_discount.dart';
import 'package:my_app/screens/tabs/management/invoice/create_edit_invoice.dart';
import 'package:my_app/screens/tabs/management/product/components/product_create_sheet.dart';

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
  const MyPopup({
    Key? key,
    required this.context,
  }) : super(key: key);
  static List<Map> popupItems = [
    {
      "name": "Product",
      "icon": AppAssets.icProduct,
      "onTap": () => {ProductCreateSheet().open()}
    },
    {
      "name": "Category",
      "icon": AppAssets.icCategory,
      "onTap": () => {Get.to(() => const CreateCategory())},
    },
    {
      "name": "Invoice",
      "icon": AppAssets.icInvoice,
      "onTap": () => {Get.to(() => const CreateInvoice())},
    },
    {
      "name": "Discount",
      "icon": AppAssets.icDiscount,
      "onTap": () => {Get.to(() => const CreateDiscount())},
    },
  ];

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
                color: AppColors.dark,
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
                      popupItems[index]["onTap"]();
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: AppColors.borderColor, width: 1),
                          ),
                          child: SizedBox(width: 25, height: 25, child: SvgPicture.asset(popupItems[index]["icon"])),
                        ),
                        const SizedBox(
                          width: 1,
                          height: 8,
                        ),
                        Text(popupItems[index]["name"]),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
