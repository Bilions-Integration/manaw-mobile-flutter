import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/invoice_model/invoice_model.dart';

import '../create_edit_invoice.dart';
import 'item_detail.dart';

class ListItems extends StatelessWidget {
  const ListItems({
    Key? key, 
    required this.type,
    required this.invoices, 
    required this.delete, 
    required this.print, 
    required this.getData, 
    required this.scrollController,
    required this.isLoading, 
  }) : super(key: key);

  final List<InvoiceModel> invoices;
  final Future<dynamic> Function(int? id) delete;
  final Future<dynamic> Function(int? id) print;
  final Future<dynamic> Function() getData;
  final ScrollController scrollController;
  final bool isLoading;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: isLoading ? Styles.loading
        : invoices.isEmpty
        ? Styles.emptyList('No invoice yet', AppAssets.emptyInvoice, 'Create new Invoice', const CreateInvoice())
        : ListView.builder(
        controller: scrollController,
        itemCount: invoices.length,
        itemBuilder: (context,int index) => Column(
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
              // onTap : () => actionPopup(
              //   context : context,
              //   invoice : invoices[index],
              //   delete : delete,
              //   print : print,
              //   type : type
              // ),
              child : listItem(invoices[index], context)
            ),
            mb(1.2),
          ],
        )
      ),
    );
  }

  Widget listItem(invoice, context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color : const Color(0xffE2E2E2),
        )
      ),
      child : Column(
        children: [
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
              Text('Customer', style: Styles.label),
              Text('Account', style: Styles.label),
            ]
          ),
          mb(0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(invoice.receiver["receiver_name"], style: Styles.textBold),
              Text(invoice.account["bank_name"], style: Styles.textBold),
            ]
          ),
          hr(height: 0.5, mt : 1.5, mb : 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text('\$${invoice.grand_total}', style: Styles.h4),
            ]
          ),
        ],
      )
    );
  }
}