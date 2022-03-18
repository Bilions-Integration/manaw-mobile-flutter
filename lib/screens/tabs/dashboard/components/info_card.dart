import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.lightGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: [
            SvgPicture.asset(
              AppAssets.icRevenue,
            ),
            mb(1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_downward),
                Text('10%'),
              ],
            ),
            mb(1),
            Text(
              'B ${cast(19737)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            mb(1),
            Text(
              'Total Revenue',
              style: TextStyle(color: AppColors.grey),
            )
          ],
        ),
      ),
    );
  }
}
