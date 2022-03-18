import 'package:flutter/material.dart';

class DashboardTopProducts extends StatefulWidget {
  const DashboardTopProducts({Key? key}) : super(key: key);

  @override
  State<DashboardTopProducts> createState() => _DashboardTopProductsState();
}

class _DashboardTopProductsState extends State<DashboardTopProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Products'),
    );
  }
}
