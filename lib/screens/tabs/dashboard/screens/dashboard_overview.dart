import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/chart_data_model.dart';
import 'package:my_app/screens/tabs/dashboard/components/info_card.dart';
import 'package:my_app/screens/tabs/dashboard/components/line_graph.dart';

class DashboardOverview extends StatefulWidget {
  final DashboardInfo? sale;
  final DashboardInfo? expense;
  final double profit;

  const DashboardOverview({
    Key? key,
    required this.profit,
    required this.expense,
    required this.sale,
  }) : super(key: key);

  @override
  State<DashboardOverview> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends State<DashboardOverview> {
  @override
  Widget build(BuildContext context) {
    return borderRadiusCard(
      10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  'Gross Profit',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${currency()} ${cast(widget.profit)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          hr(),
          mb(1.5),
          Text(
            'Sale Overview',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
          LineGraph(chartData: widget.sale?.graph ?? []),
          mb(1.5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mr(1.5),
              InfoCard(
                balance: widget.sale?.balance ?? 0,
                title: widget.sale?.title ?? '',
                percent: widget.sale?.percent ?? 0,
                icon: SvgPicture.asset(
                  AppAssets.icRevenue,
                ),
              ),
              mr(1.5),
              InfoCard(
                balance: widget.expense?.balance ?? 0,
                title: widget.expense?.title ?? '',
                percent: widget.expense?.percent ?? 0,
                icon: SvgPicture.asset(
                  AppAssets.icExpense,
                ),
              ),
              mr(1.5),
            ],
          ),
          mb(2),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
