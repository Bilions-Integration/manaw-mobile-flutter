import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class OptionsMenu {
  final List<Map> options = [
    {
      "name": "Edit",
      "icon": AppAssets.icEdit,
      "action": "edit",
    },
    {
      "name": "Enable Selling",
      "icon": AppAssets.icSelling,
      "action": "enable_selling",
    },
    {
      "name": "Negative Sale",
      "icon": AppAssets.icNegativeStock,
      "action": "negative_stock",
    },
    {
      "name": "Remove All Products",
      "type": "danger",
      "icon": AppAssets.icDelete,
      "action": "remove_all",
    },
  ];
  void open() {
    final context = currentContext();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 7,
              left: 10,
              right: 10,
            ),
            child: Column(children: [
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
                      onTap: () =>
                          console.log("Option tapped" + option['action']),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SvgPicture.asset(option["icon"]),
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              option["name"],
                              style: TextStyle(
                                fontSize: 17,
                                color: option['type'] == 'danger'
                                    ? AppColors.red
                                    : AppColors.black,
                              ),
                            )
                          ],
                        ),
                      )),
                )
            ]),
          ),
        );
      },
    );
  }
}
