import 'package:flutter/material.dart';
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
    ChartData('Jan', 35),
    ChartData('Feb', 13),
    ChartData('Mar', 34),
    ChartData('Apr', 27),
    ChartData('May', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return borderRadiusCard(
      10,
      Column(
        children: [
          LineGraph(chartData: chartData),
          mb(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              InfoCard(),
              InfoCard(),
            ],
          ),
          mb(2),
        ],
      ),
    );
  }
}
