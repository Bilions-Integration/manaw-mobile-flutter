class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class DashboardInfo {
  final double percent;
  final String title;
  final double balance;
  final List<ChartData>? graph;

  const DashboardInfo({
    required this.title,
    required this.percent,
    required this.balance,
    this.graph,
  });
}
