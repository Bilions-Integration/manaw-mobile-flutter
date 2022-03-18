import 'package:flutter/material.dart';

class DashboardTopCustomers extends StatefulWidget {
  const DashboardTopCustomers({Key? key}) : super(key: key);

  @override
  State<DashboardTopCustomers> createState() => _DashboardTopCustomersState();
}

class _DashboardTopCustomersState extends State<DashboardTopCustomers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Customers'),
    );
  }
}
