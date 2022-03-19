import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';

class LinkItem extends StatelessWidget {
  const LinkItem({
    Key? key,
    required this.name,
    this.count,
    this.unit,
    required this.page,
  }) : super(key: key);

  final String name;
  final int? count;
  final String? unit;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {Get.to(page)},
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 14, bottom: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              children: [
                Text(
                  count != null && count! > 0 ? '$count $unit' : '',
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
