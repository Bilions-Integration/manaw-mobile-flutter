import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 13),
      ChartData(2012, 34),
      ChartData(2013, 27),
      ChartData(2014, 40),
    ];
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          child: SfCartesianChart(
            enableAxisAnimation: true,
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: NumericAxis(
              axisLine: AxisLine(color: AppColors.dark, width: 2),
            ),
            series: <ChartSeries>[
              // Renders spline chart
              SplineSeries<ChartData, int>(
                enableTooltip: true,
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                markerSettings: const MarkerSettings(isVisible: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
