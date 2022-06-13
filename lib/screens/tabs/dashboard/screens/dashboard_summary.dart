import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/dashboard_summary_model.dart';

class DashboardSummary extends StatefulWidget {
  final DashboardSummaryModel? summary;
  const DashboardSummary({Key? key, this.summary}) : super(key: key);

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
                  'summary'.tr,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                mb(2),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icCapital),
                  title: 'capital'.tr,
                  value: (widget.summary?.assets ?? 0) -
                      (widget.summary?.liability ?? 0),
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icAssets),
                  title: 'assets'.tr,
                  value: widget.summary?.assets ?? 0,
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icWallet),
                  title: 'totalLiability'.tr,
                  value: widget.summary?.liability ?? 0,
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
                  'taxes'.tr,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                mb(2),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icSaleTax),
                  title: 'saleTax'.tr,
                  value: widget.summary?.saleTax ?? 0,
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icPurchaseTax),
                  title: 'purchaseTax'.tr,
                  value: widget.summary?.purchaseTax ?? 0,
                ),
                SummaryList(
                  icon: SvgPicture.asset(AppAssets.icSaleTax),
                  title: 'whtTax'.tr,
                  value: widget.summary?.wht ?? 0,
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
