import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/dashboard/components/dashboard_upper_tabs.dart';
import 'package:my_app/screens/tabs/dashboard/components/date_picker.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_overview.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_summary.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_top_customers.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_top_products.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String screen = 'overview';

  Map screens = {
    "overview": const DashboardOverview(),
    "summary": const DashboardSummary(),
    "top_products": const DashboardTopProducts(),
    "top_customers": const DashboardTopCustomers(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F0F0F0'),
      body: Column(children: [
        DatePicker(),
        mb(1.5),
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
          child: DashboardUpperTabs(
            screenChanged: (String s) {
              setState(() {
                screen = s;
              });
            },
          ),
        ),
        mb(2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: ListView(children: [screens[screen]]),
          ),
        )
      ]),
    );
  }
}
