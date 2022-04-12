import 'package:flutter/material.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/invoice_model.dart';

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
      child: isLoading ?
        const Text('hi') : ListView.builder(
        controller: scrollController,
        itemCount: invoices.length,
        itemBuilder: (context,int index) => Column(
          children: [
            InkWell(
              onTap : () => actionPopup(
                context : context,
                invoice : invoices[index],
                delete : delete,
                print : print,
                type : type
              ),
              child : listItem(invoices[index])
            ),
            mb(1.2),
          ],
        )
      ),
    );
  }

  Widget listItem(invoice) {
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
              Text(invoice.invoice_number, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              )),
              Text(invoice.created_at),
            ]
          ),
          mb(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Customer', style: TextStyle(
                color: Color.fromRGBO(0,0,0,0.5)
              )),
              Text('Account', style: TextStyle(
                color: Color.fromRGBO(0,0,0,0.5)
              )),
            ]
          ),
          mb(0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(invoice.receiver["name"], style: const TextStyle(
                fontWeight: FontWeight.bold
              )),
              Text(invoice.account["bank_name"], style: const TextStyle(
                fontWeight: FontWeight.bold
              )),
            ]
          ),
          hr(height: 0.5, mt : 1.5, mb : 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text('\$${invoice.grand_total}', style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              )),
            ]
          ),
        ],
      )
    );
  }
}