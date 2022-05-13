import 'package:flutter/material.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/components/date_picker.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/model/report_model.dart';
import 'package:my_app/screens/tabs/management/report/components/report_list.dart';
import 'package:my_app/screens/tabs/management/report/report_controller.dart';
import 'package:my_app/services/invoice_services.dart';

class ManageReport extends StatefulWidget {
  const ManageReport({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageReport> createState() => _ManageReportState();
}

class _ManageReportState extends State<ManageReport> {
  bool isSearch = false;
  bool isLoading = false;
  bool canLoadMore = false;
  List<Report> reports = [];
  var reportController = ReportController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: customAppBar2(
        context: context,
        title: "Inventory Report",
        isSearch: isSearch,
        toggleSearch: _toggleSearch,
        search: _onSearch,
      ),
      body: Column(
        children: [
          DatePicker(
            startDate: reportController.params['date_from'],
            endDate: reportController.params['date_to'],
            onDateChanged: _onDateChange,
          ),
          Expanded(
            child: ReportList(
              isLoading: isLoading,
              reports: reports,
              print: (id) => _printData(id),
              isLastPage: canLoadMore,
              loadMore: _loadMore,
              refresh: _refresh,
              params: reportController.params,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
    _getData();
  }

  _getData() async {
    setState(() {
      isLoading = true;
    });
    List<Report> res = await reportController.getReports();
    setState(() {
      reports = res;
      isLoading = false;
    });
  }

  _loadMore() async {
    var res = await reportController.getReports();
    setState(() {
      reports = [...reports, ...res];
      canLoadMore = reportController.canLoadMore;
    });
  }

  _onDateChange(startDate, endDate) {
    setState(() {
      reportController.params['date_from'] = startDate;
      reportController.params['date_to'] = endDate;
    });
    _getData();
  }

  _onSearch(value) {
    setState(() {
      reportController.params['keyword'] = value;
      _getData();
    });
  }

  _printData(int? id) async {
    await InvoiceServices.print(id);
  }

  _refresh() async {
    var res = await reportController.getReports();
    setState(() {
      reports = res;
      canLoadMore = reportController.canLoadMore;
    });
  }

  _toggleSearch() {
    setState(() {
      isSearch = !isSearch;
      if (!isSearch) {
        reportController.params['keyword'] = '';
        _getData();
      }
    });
  }
}
