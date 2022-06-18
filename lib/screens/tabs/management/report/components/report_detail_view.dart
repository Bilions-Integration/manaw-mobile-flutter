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
            ? Center(
                child: Text('error'.tr),
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
                                Text('createdAt'.tr, style: Styles.label),
                                mb(1),
                                Text(
                                  'invoice'.tr,
                                  style: Styles.t2,
                                ),
                                mb(0.7),
                                Text('invoiceNumber'.tr, style: Styles.label),
                                mb(1),
                                Text('invoiceDate'.tr, style: Styles.label),
                                mb(1),
                                Text('totalPrice'.tr, style: Styles.label),
                                mb(1),
                                Text(
                                  'customer'.tr,
                                  style: Styles.t2,
                                ),
                                mb(0.7),
                                Text('name'.tr, style: Styles.label),
                                mb(1),
                                Text('email'.tr, style: Styles.label),
                                mb(1),
                                Text('phone'.tr, style: Styles.label),
                                mb(1),
                                Text(
                                  'account'.tr,
                                  style: Styles.t2,
                                ),
                                mb(0.7),
                                Text('bankName'.tr, style: Styles.label),
                                mb(1),
                                Text('ownerName'.tr, style: Styles.label),
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
                          Text('quantity'.tr, style: Styles.label),
                          Text('${report.currency} ${report.quantity}'),
                        ],
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('unitPrice'.tr, style: Styles.label),
                          Text('${report.currency} ${report.unitPrice}'),
                        ],
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('salePrice'.tr, style: Styles.label),
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
