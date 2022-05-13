import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/moment.dart';
import 'package:my_app/model/report_model.dart';

class ReportController {
  Map<String, dynamic> params = {
    'page': 1,
    'limit': 10,
    'date_to': moment.string(DateTime.now()),
    'date_from': moment.string(DateTime(
        DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
    'keyword': null,
  };
  bool canLoadMore = false;

  Future<List<Report>> getReports() async {
    var res = await Api.get("inventories", data: params, showLoading: false);
    if (res['success']) {
      canLoadMore = res['data']['can_load_more'];
      return (res['data']['data'] as List)
          .map((e) => Report.fromJson(e))
          .toList();
    }
    return [];
  }
}
