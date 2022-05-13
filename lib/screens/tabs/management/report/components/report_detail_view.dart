import 'package:flutter/material.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/report_model.dart';
import 'package:my_app/screens/tabs/management/report/report_controller.dart';

class ReportDetailView extends StatefulWidget {
  final int reportId;
  const ReportDetailView({required this.reportId, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetailView> {
  late Report report;
  bool isLoading = false;
  bool hasError = false;
  var reportController = ReportController();

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() {
    setState(() {
      isLoading = true;
    });
    reportController.getReportDetail(reportId: widget.reportId).then((res) {
      setState(() {
        if (res != null) {
          report = res;
        } else {
          hasError = true;
        }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingWidget(
            title: 'Loading',
          )
        : hasError
            ? const Center(
                child: Text('Error '),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mb(1),
                  Text(report.invoiceNumber, style: Styles.h3),
                  mb(1.5),
                  Expanded(
                    child: ListView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date', style: Styles.label),
                          mb(1),
                          Text('Account', style: Styles.label),
                          mb(1),
                          Text('Shipping Address', style: Styles.label),
                          mb(1),
                          Text('Customer/Supplier', style: Styles.label),
                          mb(1),
                          Text('Phone', style: Styles.label),
                        ],
                      ),
                      mr(3),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(report.unit),
                            mb(1),
                            Text(report.account?.bankName ?? '-'),
                            mb(1),
                            Text(report.customer?.receiverName ?? '-'),
                            mb(1),
                            Text(report.customer?.receiverEmail ?? '-'),
                            mb(1),
                            Text(report.customer?.receiverPhone ?? '-'),
                          ])
                    ]),
                  ),
                  hr(height: 1, mt: 1.5),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SubTotal', style: Styles.label),
                          Text('\$${report.totalSalePrice}'),
                        ],
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax', style: Styles.label),
                          // Text('\$${invoice.taxValue}'),
                        ],
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: Styles.textBold),
                          // Text('\$${invoice.grandTotal}', style: Styles.textBold),
                        ],
                      ),
                    ],
                  ),
                ],
              );
  }
}
