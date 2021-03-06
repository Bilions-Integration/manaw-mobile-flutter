import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_item_list.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/invoice_model/invoice_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/management/invoice/components/invoice_detail.dart';

class InvoiceList extends StatelessWidget {
  final List<InvoiceModel> invoices;

  final Future<dynamic> Function(int? id) delete;
  final Future<dynamic> Function(int? id) print;
  final bool isLoading;
  final String type;
  final bool isLastPage;
  final Function() refresh;
  final Function() loadMore;
  final Map<String, dynamic> params;
  const InvoiceList({
    Key? key,
    required this.type,
    required this.invoices,
    required this.delete,
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
      items: invoices,
      params: params,
      loadMore: loadMore,
      isLoading: isLoading,
      isLastPage: isLastPage,
      emptyWidget: Styles.emptyList(
        label: 'emptyInvoice'.tr,
        image: AppAssets.emptyInvoice,
        buttonLabel: 'createInvoice'.tr,
        link: RouteName.product,
      ),
      itemBuilder: (context, index) => Column(
        children: [
          InkWell(
            onTap: () => Styles.customBottomSheet(
              context,
              95,
              InvoiceDetailView(
                invoice: invoices[index],
                delete: delete,
                print: print,
                type: type,
              ),
            ),
            child: listItem(
              invoices[index],
              context,
            ),
          ),
          mb(1),
        ],
      ),
    );
  }

  Widget listItem(InvoiceModel invoice, context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: AppColors.white,
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            invoice.invoiceNumber,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
            ),
          ),
          Text(invoice.createdAt),
        ]),
        mb(0.2),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('customer'.tr, style: Styles.l5),
          Text('account'.tr, style: Styles.l5),
        ]),
        mb(0.5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(invoice.receiver?.receiverName ?? '-', style: Styles.h5),
          Text(invoice.account?.bankName ?? '-', style: Styles.h5),
        ]),
        hr(height: 1, mt: 1.5, mb: 1.5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('total'.tr),
          Text('${currency()} ${invoice.grandTotal}', style: Styles.h4),
        ]),
      ]),
    );
  }
}
