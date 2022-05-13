import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class LinkItem extends StatelessWidget {
  final String name;

  final int? count;
  final String? unit;
  final Widget page;
  final String icon;
  const LinkItem({
    Key? key,
    required this.name,
    required this.icon,
    this.count,
    this.unit,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {Get.to(page)},
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            borderRadiusCard(
              10,
              SvgPicture.asset(
                icon,
                width: 18,
              ),
              color: AppColors.lightGrey,
              padding: 7,
            ),
            mr(1),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
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
