import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/moment.dart';
import 'package:my_app/screens/tabs/dashboard/components/chart_data_model.dart';
import 'package:my_app/screens/tabs/dashboard/dashboard_controller.dart';

class DashboardService {
  static Map<String, dynamic> _getDates() {
    final dashboardController = Get.find<DashboardController>();
    final startDate = dashboardController.startDate.value;
    final endDate = dashboardController.endDate.value;
    return {
      "start_date": moment.onlyDate(startDate),
      "end_date": moment.onlyDate(endDate),
    };
  }

  static Future getGrossProfitGraph() async {
    var res = await Api.get(
      '/dashboard/graph/profit',
      data: DashboardService._getDates(),
    );
    final data = res['data'];
    List graph = data['chartData']['data'];
    return {
      'value': double.parse(data['amount'].toString()),
      'graph': graph.mapIndexed((e, index) => ChartData('# ${index.toString()}', double.parse(e.toString()))).toList(),
    };
  }

  static Future getSale() async {
    var res = await Api.get(
      '/dashboard/graph/income',
      data: DashboardService._getDates(),
    );
    final data = res['data'];
    List graph = data['graph'];
    return DashboardInfo(
      title: 'Total Sale',
      percent: double.parse(data['percentage'].toString()),
      balance: double.parse(data['income'].toString()),
      graph: graph.mapIndexed((e, index) => ChartData(e['x'].toString(), double.parse(e['y'].toString()))).toList(),
    );
  }

  static Future getExpense() async {
    var res = await Api.get(
      '/dashboard/graph/expense',
      data: DashboardService._getDates(),
    );
    final data = res['data'];
    return DashboardInfo(
      title: data['name'],
      percent: double.parse(data['percentage'].toString()),
      balance: double.parse(data['amount'].toString()),
    );
  }
}
