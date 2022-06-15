import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/helpers/util_models.dart';

class OptionsMenu {
  final int? productId;
  final Function({required String action, int? productId}) handler;
  final List<Options> options = [
    Options(
      name: "edit".tr,
      icon: AppAssets.icEdit,
      action: "edit",
    ),
    Options(
        name: "addStock".tr, icon: AppAssets.icAddStock, action: "add_stock"),
    Options(
        name: "deleteProduct".tr,
        icon: AppAssets.icDelete,
        action: "delete",
        type: "danger"),
  ];
  OptionsMenu({this.productId, required this.handler});
  void open() {
    final context = currentContext();
    showModalBottomSheet(
      context: context,
      shape: Styles.topOnlyBorderRadius(15),
      builder: (builder) {
        return SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
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
                const SizedBox(
                  width: 10,
                  height: 12,
                ),
                for (var option in options)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: InkWell(
                      onTap: () => {
                        Navigator.pop(context),
                        handler(action: option.action, productId: productId)
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              option.icon,
                              width: 25,
                              color: option.type == 'danger'
                                  ? AppColors.red
                                  : AppColors.black,
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              option.name,
                              style: TextStyle(
                                fontSize: 17,
                                color: option.type == 'danger'
                                    ? AppColors.red
                                    : AppColors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
