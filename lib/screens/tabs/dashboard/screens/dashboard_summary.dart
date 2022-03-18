import 'package:flutter/material.dart';

class DashboardSummary extends StatefulWidget {
  const DashboardSummary({Key? key}) : super(key: key);

  @override
  State<DashboardSummary> createState() => _DashboardSummaryState();
}

class _DashboardSummaryState extends State<DashboardSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Summary'),
    );
  }
}
