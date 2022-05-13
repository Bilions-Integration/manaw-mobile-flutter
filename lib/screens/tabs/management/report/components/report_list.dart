import 'package:flutter/material.dart';
import 'package:my_app/components/custom_item_list.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/report_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/management/invoice/components/invoice_detail.dart';
import 'package:my_app/screens/tabs/management/report/components/report_detail_view.dart';

class ReportList extends StatelessWidget {
  final List<Report> reports;

  final Future<dynamic> Function(int? id) print;
  final bool isLoading;
  final bool isLastPage;
  final Function() refresh;
  final Function() loadMore;
  final Map<String, dynamic> params;
  const ReportList({
    Key? key,
    required this.reports,
    required this.print,
    required this.isLoading,
    required this.isLastPage,
    required this.refresh,
    required this.loadMore,
    required this.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomItemList(
      refresh: refresh,
      items: reports,
      params: params,
      loadMore: loadMore,
      isLoading: isLoading,
      isLastPage: isLastPage,
      emptyWidget: Styles.emptyList(
          label: 'No Reports yet', image: AppAssets.emptyInvoice),
      itemBuilder: (context, index) => Column(
        children: [
          InkWell(
            onTap: () => Styles.customBottomSheet(
              context,
              95,
              ReportDetailView(
                reportId: reports[index].id,
              ),
            ),
            child: listItem(
              reports[index],
              context,
            ),
          ),
          mb(1),
        ],
      ),
    );
  }

  Widget listItem(Report report, context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: AppColors.borderColor, width: 2),
        color: AppColors.white,
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            report.invoiceNumber,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(report.createdAt),
        ]),
        mb(0.3),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(report.name, style: Styles.h4),
          Text('${report.quantity} Pc${report.quantity > 1 ? 's' : ''}',
              style: Styles.l4),
        ]),
        hr(height: 1, mt: 1.5, mb: 1),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Unit Price'),
          Text('${currency()} ${report.unitPrice}', style: Styles.h4),
        ]),
      ]),
    );
  }
}
