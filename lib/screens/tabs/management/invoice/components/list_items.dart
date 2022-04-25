import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/invoice_model/invoice_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/components/custom_item_list.dart';
import 'item_detail.dart';

class ListItems extends StatelessWidget {
  const ListItems({
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

  final List<InvoiceModel> invoices;
  final Future<dynamic> Function(int? id) delete;
  final Future<dynamic> Function(int? id) print;
  final bool isLoading;
  final String type;
  final bool isLastPage;
  final Function() refresh;
  final Function() loadMore;
  final Map<String,dynamic> params;

  @override
  Widget build(BuildContext context) {
    return CustomItemList(
      refresh: refresh,
      items: invoices, 
      params: params, 
      loadMore: loadMore, 
      isLoading: isLoading, 
      isLastPage: isLastPage, 
      emptyWidget: Styles.emptyList('No Invoice yet', AppAssets.emptyInvoice, 'Create new Invoice', RouteName.product),
      itemBuilder: (context, index) => Column(
        children: [
          InkWell(
            onTap : () => Styles.customBottomSheet(context, 95,
              ItemDetailCard(
                invoice : invoices[index],
                delete : delete,
                print : print,
                type : type
              )
            ),
            child : listItem(invoices[index], context)
          ),
          mb(1),
        ],
      ),
    );
  }

  Widget listItem(invoice, context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color : const Color(0xffE2E2E2),
        )
      ),
      child: Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(invoice.invoice_number, style: Styles.h3),
              Text(invoice.created_at),
            ]
          ),
          mb(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Customer', style: Styles.l5),
              Text('Account', style: Styles.l5),
            ]
          ),
          mb(0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(invoice.receiver["receiver_name"], style: Styles.h5),
              Text(invoice.account["bank_name"], style: Styles.h5),
            ]
          ),
          hr(height: 1, mt: 1.5, mb: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text('\$${invoice.grand_total}', style: Styles.h4),
            ]
          ),
        ]
      ),
    );
  }
}