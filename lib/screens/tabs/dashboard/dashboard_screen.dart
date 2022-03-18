import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/dashboard/components/chart_data_model.dart';
import 'package:my_app/screens/tabs/dashboard/components/dashboard_upper_tabs.dart';
import 'package:my_app/screens/tabs/dashboard/components/date_picker.dart';
import 'package:my_app/screens/tabs/dashboard/dashboard_controller.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_overview.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_summary.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_top_customers.dart';
import 'package:my_app/screens/tabs/dashboard/screens/dashboard_top_products.dart';
import 'package:my_app/services/dashboard_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // states
  int currentScreen = 0;
  double profit = 0;
  DashboardInfo? sale;
  DashboardInfo? expense;

  final dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F0F0F0'),
      body: Column(children: [
        DatePicker(
          onDateChanged: _dateChanged,
        ),
        mb(1.5),
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
          child: DashboardUpperTabs(
            screenChanged: (int s) {
              setState(() {
                currentScreen = s;
              });
            },
          ),
        ),
        mb(2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: ListView(children: [
              IndexedStack(
                index: currentScreen,
                children: [
                  DashboardOverview(
                    profit: profit,
                    sale: sale,
                    expense: expense,
                  ),
                  const DashboardSummary(),
                  const DashboardTopProducts(),
                  const DashboardTopCustomers()
                ],
              )
            ]),
          ),
        )
      ]),
    );
  }

  _dateChanged(startDate, endDate) {
    _reload();
  }

  _reload() {
    Future.delayed(const Duration(microseconds: 500), () async {
      _getGrossProfit();
      _getSale();
      _getExpense();
    });
  }

  _getGrossProfit() async {
    var res = await DashboardService.getGrossProfitGraph();
    setState(() {
      profit = res['value'];
    });
  }

  _getSale() async {
    DashboardInfo res = await DashboardService.getSale();
    setState(() {
      sale = res;
    });
  }

  _getExpense() async {
    DashboardInfo res = await DashboardService.getExpense();
    setState(() {
      expense = res;
    });
  }
}
