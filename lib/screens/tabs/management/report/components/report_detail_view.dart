import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/moment.dart';
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
                  Text(report.name, style: Styles.h3),
                  mb(0.5),
                  Text(
                    report.invoiceNumber,
                    style: Styles.h6,
                  ),
                  mb(1.5),
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Created at', style: Styles.label),
                                mb(1),
                                const Text(
                                  'Invoice',
                                  style: Styles.t2,
                                ),
                                mb(0.7),
                                const Text('Invoice Number',
                                    style: Styles.label),
                                mb(1),
                                const Text('Invoice Date', style: Styles.label),
                                mb(1),
                                const Text('Total Price', style: Styles.label),
                                mb(1),
                                const Text(
                                  'Customer',
                                  style: Styles.t2,
                                ),
                                mb(0.7),
                                const Text('Name', style: Styles.label),
                                mb(1),
                                const Text('Email', style: Styles.label),
                                mb(1),
                                const Text('Phone', style: Styles.label),
                                mb(1),
                                const Text(
                                  'Account',
                                  style: Styles.t2,
                                ),
                                mb(0.7),
                                const Text('Bank Name', style: Styles.label),
                                mb(1),
                                const Text('Owner Name', style: Styles.label),
                              ],
                            ),
                            mr(3),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(report.createdAt),
                                mb(1),
                                const Text(''),
                                mb(1),
                                Text(report.invoiceNumber),
                                mb(1),
                                Text(moment.string(
                                    DateTime.parse(report.invoiceDate ?? ''))),
                                mb(1),
                                Text(report.currency +
                                    report.invoiceTotalPrice.toString()),
                                mb(1),
                                const Text(''),
                                mb(1),
                                Text(report.customer?.receiverName ?? '-'),
                                mb(1),
                                Text(report.customer?.receiverEmail ?? '-'),
                                mb(1),
                                Text(report.customer?.receiverPhone ?? '-'),
                                const Text(''),
                                mb(1),
                                Text(report.account?.bankName ?? '-'),
                                mb(1),
                                Text(report.account?.ownerName ?? '-'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  hr(height: 1, mt: 1.5),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Quantity', style: Styles.label),
                          Text('${report.currency} ${report.quantity}'),
                        ],
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Unit Price', style: Styles.label),
                          Text('${report.currency} ${report.unitPrice}'),
                        ],
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sale Price', style: Styles.label),
                          Text('${report.currency} ${report.unitSalePrice}'),
                        ],
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('totalSale'.tr, style: Styles.textBold),
                          Text(
                            '${report.currency} ${report.totalSalePrice}',
                            style: Styles.textBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
  }

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
}
