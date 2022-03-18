import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/product/create_edit_product.dart';

class ProductCreateSheet {
  final context = currentContext();

  void open() {
    showModalBottomSheet(
        context: context,
        shape: Styles.topOnlyBorderRadius(15),
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
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
                      "New Product",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 30,
                    runSpacing: 30,
                    children: [
                      InkWell(
                        onTap: () => {Get.to(const CreateProduct())},
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                    color: AppColors.borderColor, width: 1),
                              ),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(AppAssets.icProduct),
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                              height: 8,
                            ),
                            const Text("Single Product"),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => {Get.to(const CreateProduct())},
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                    color: AppColors.borderColor, width: 1),
                              ),
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child:
                                    SvgPicture.asset(AppAssets.icGroupProduct),
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                              height: 8,
                            ),
                            const Text("Group Product"),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
