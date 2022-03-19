import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';

class OptionsMenu {
  final List<Map> options = [
    {
      "name": "Edit",
      "icon": AppAssets.icEdit,
      "action": "edit",
    },
    {
      "name": "Add Stock",
      "icon": AppAssets.icAddStock,
      "action": "enable_selling",
    },
    {
      "name": "Delete Product",
      "type": "danger",
      "icon": AppAssets.icDelete,
      "action": "remove_all",
    },
  ];
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
                      color: AppColors.dark,
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
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: InkWell(
                        onTap: () => console.log("Option tapped" + option['action']),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                option["icon"],
                                width: 25,
                                color: option['type'] == 'danger' ? AppColors.red : AppColors.black,
                              ),
                              const SizedBox(
                                width: 20,
                                height: 20,
                              ),
                              Text(
                                option["name"],
                                style: TextStyle(
                                  fontSize: 17,
                                  color: option['type'] == 'danger' ? AppColors.red : AppColors.black,
                                ),
                              )
                            ],
                          ),
                        )),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
