import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/screens/tabs/management/product/manage_product.dart';

class LinkItem extends StatelessWidget {
  const LinkItem({
    Key? key,
    required this.name,
    required this.count,
    required this.unit,
  }) : super(key: key);

  final String name;
  final int count;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {Get.to(const ManageProduct())},
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 14, bottom: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  count > 0 ? '$count $unit' : '',
                  style: TextStyle(
                    color: AppColors.lightDark,
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
