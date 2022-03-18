import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/screens/tabs/dashboard/components/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineGraph extends StatelessWidget {
  const LineGraph({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.only(left: 3, top: 20, right: 20, bottom: 3),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        enableAxisAnimation: true,
        tooltipBehavior: TooltipBehavior(enable: true, header: 'Sale'),
        primaryXAxis: CategoryAxis(
          isVisible: true,
          // labelStyle: TextStyle(color: AppColors.white),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: AxisLine(color: AppColors.borderColor, width: 3),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 1, dashArray: [5, 5]),
          axisLine: AxisLine(color: AppColors.line, width: 0),
        ),
        series: <ChartSeries>[
          // Renders spline chart
          SplineSeries<ChartData, String>(
            color: AppColors.dark,
            enableTooltip: true,
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            markerSettings: const MarkerSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}
