import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/dashboard/components/chart_data_model.dart';
import 'package:my_app/screens/tabs/dashboard/components/info_card.dart';
import 'package:my_app/screens/tabs/dashboard/components/line_graph.dart';

class DashboardOverview extends StatefulWidget {
  const DashboardOverview({Key? key}) : super(key: key);

  @override
  State<DashboardOverview> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends State<DashboardOverview> {
  final List<ChartData> chartData = [
    ChartData('Jan', 10),
    ChartData('Feb', 20),
    ChartData('Mar', 30),
    ChartData('Apr', 20),
    ChartData('May', 15),
    ChartData('Jun', 70),
    ChartData('Jul', 50),
    ChartData('Aug', 10),
    ChartData('Sep', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return borderRadiusCard(
      10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Text(
              'Gross Profit',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Text(
              '${currency()} ${cast(94873837.98)}',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          LineGraph(chartData: chartData),
          mb(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mr(1.5),
              const InfoCard(
                balance: 13340,
                title: 'Total Sale',
                percent: 10,
              ),
              mr(1.5),
              const InfoCard(
                balance: 233.23,
                title: 'Cost of Goods',
                percent: -20,
              ),
              mr(1.5),
            ],
          ),
          mb(2),
        ],
      ),
    );
  }
}
