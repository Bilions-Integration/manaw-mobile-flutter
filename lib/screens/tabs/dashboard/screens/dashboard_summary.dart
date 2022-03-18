import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class DashboardSummary extends StatefulWidget {
  const DashboardSummary({Key? key}) : super(key: key);

  @override
  State<DashboardSummary> createState() => _DashboardSummaryState();
}

class _DashboardSummaryState extends State<DashboardSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        borderRadiusCard(
          10,
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                mb(2),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icCapital),
                  title: 'Capital',
                  value: 10000,
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icAssets),
                  title: 'Assets',
                  value: 10000,
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icWallet),
                  title: 'Total Liability',
                  value: 10000,
                ),
              ],
            ),
          ),
        ),
        mb(1.5),
        borderRadiusCard(
          10,
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Taxes',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                mb(2),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icSaleTax),
                  title: 'Sale Tax',
                  value: 10000,
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icPurchaseTax),
                  title: 'Purchase Tax',
                  value: 10000,
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icSaleTax),
                  title: 'Withholding Tax',
                  value: 10000,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SummaryList extends StatelessWidget {
  final Widget icon;
  final String title;
  final double value;

  const SummaryList({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Row(
            children: [
              icon,
              mr(0.5),
              Text(title),
            ],
          ),
          const Spacer(),
          Text('${currency()} ${cast(value)}')
        ],
      ),
    );
  }
}
