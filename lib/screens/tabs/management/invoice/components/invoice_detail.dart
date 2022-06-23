import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/invoice_model/invoice_model.dart';
import 'package:my_app/model/invoice_model/product_model.dart';
import 'package:my_app/services/pos_service.dart';

void actionPopup({
  required BuildContext context,
  required dynamic invoice,
  required String type,
  required Future<dynamic> Function(int? id) delete,
  required Future<dynamic> Function(int? id) print,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: InvoiceDetailView(
        invoice: invoice,
        delete: delete,
        print: print,
        type: type,
      ),
    ),
  );
}

class InvoiceDetailView extends StatefulWidget {
  final dynamic invoice;
  final Future<dynamic> Function(int? id) delete;
  final Future<dynamic> Function(int? id) print;
  final String type;

  const InvoiceDetailView({
    Key? key,
    required this.invoice,
    required this.delete,
    required this.print,
    required this.type,
  }) : super(key: key);

  @override
  State<InvoiceDetailView> createState() => _InvoiceDetailViewState();
}

class _InvoiceDetailViewState extends State<InvoiceDetailView> {
  // ignore: prefer_typing_uninitialized_variables
  var testing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _titleAndActions(widget.invoice, widget.delete, widget.type),
        Column(children: [
          mb(6),
          _invoiceInfo(widget.invoice),
          _productLists(context, widget.invoice.products),
          mb(17),
        ]),
        _priceDetail(widget.invoice)
      ],
    );
  }

  _getVariationName(ProductModel product) {
    if (product.unit != null && product.unit?.id != null) {
      return '(${product.unit?.name})';
    }
    return '';
  }

  _invoiceInfo(InvoiceModel invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mb(1),
        Text(invoice.invoiceNumber, style: Styles.h3),
        mb(1.5),
        Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('invoiceDate'.tr, style: Styles.label),
              mb(1),
              Text('account'.tr, style: Styles.label),
              mb(1),
              Text('shippingAddress'.tr, style: Styles.label),
              mb(1),
              Text('customerSupplier'.tr, style: Styles.label),
              mb(1),
              Text('phone'.tr, style: Styles.label),
              if (widget.type == 'sale') ...[
                mb(1),
                Text('customerNote'.tr, style: Styles.label)
              ],
            ],
          ),
          mr(3),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(invoice.invoiceDate),
              mb(1),
              Text(invoice.account?.bankName ?? '-'),
              mb(1),
              Text(invoice.receiver?.shippingAddress ?? '-'),
              mb(1),
              Text(invoice.receiver?.receiverName ?? '-'),
              mb(1),
              Text(invoice.receiver?.receiverPhone ?? '-'),
              if (widget.type == 'sale') ...[mb(1), Text(invoice.note ?? '-')],
            ]),
          )
        ]),
        hr(height: 1, mt: 1.5),
      ],
    );
  }

  _priceDetail(invoice) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        child: Column(
          children: [
            hr(height: 1, mt: 1, mb: 1),
            Column(
              children: [
                testing != null ? Image.memory(testing) : mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('subTotal'.tr, style: Styles.label),
                    Text('\$${invoice.total}'),
                  ],
                ),
                mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('tax'.tr, style: Styles.label),
                    Text('\$${invoice.taxValue}'),
                  ],
                ),
                mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('total'.tr, style: Styles.textBold),
                    Text('\$${invoice.grandTotal}', style: Styles.textBold),
                  ],
                ),
                mb(1.5),
                PrimaryButton(
                  value: Platform.isAndroid ? 'print'.tr : 'downloadReceipt'.tr,
                  onPressed: () => {_zPrint(invoice.id)},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _productLists(context, List<ProductModel> products) {
    return Expanded(
      child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            return Column(children: [
              mb(1.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${product.quantity} x ', style: Styles.label),
                        Expanded(
                          child: Text(
                            '${product.name} ${_getVariationName(product)}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  mr(3),
                  Text('\$${product.quantity * product.price}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'customerNote'.tr,
                    style: Styles.label,
                  ),
                  Text(product.note ?? '-'),
                ],
              ),
            ]);
          }),
    );
  }

  _titleAndActions(invoice, delete, type) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            SvgPicture.asset(AppAssets.invoiceIcon, width: 47, height: 47),
            mr(1),
            Text(type == 'sale' ? 'saleInvoice'.tr : 'purchaseInvoice'.tr,
                style: Styles.h3),
          ]),
          Row(children: [
            IconButton(
              onPressed: () {
                _zDownloadReceipt(invoice.id);
              },
              icon: const Icon(Icons.download_rounded),
            ),
            InkWell(
              child: SvgPicture.asset(AppAssets.trash, width: 20, height: 20),
              onTap: () => delete(invoice.id),
            ),
          ])
        ]),
        hr(height: 1, mt: 1),
      ],
    );
  }

  _zDownloadReceipt(invoiceId) async {
    PosService service = PosService();
    service.downloadReceipt(invoiceId);
  }

  _zPrint(invoiceId) async {
    PosService service = PosService();
    service.print(invoiceId);
  }
}
