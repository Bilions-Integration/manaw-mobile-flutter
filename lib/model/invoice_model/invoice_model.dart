import 'package:my_app/helpers/moment.dart';

import 'invoice_account_model.dart';
import 'product_model.dart';
import 'receiver_model.dart';

class InvoiceModel {
  final int id;
  final String type;
  final String invoiceDate;
  final num total;
  final num grandTotal;
  final String invoiceNumber;
  final num taxValue;
  final String createdAt;
  final InvoiceAccountModel? account;
  final List<ProductModel> products;
  final String? dueDate;
  final ReceiverModel? receiver;

  InvoiceModel({
    required this.id,
    required this.type,
    required this.invoiceDate,
    required this.total,
    required this.grandTotal,
    required this.invoiceNumber,
    required this.taxValue,
    required this.createdAt,
    required this.account,
    required this.products,
    required this.dueDate,
    required this.receiver,
  });

  InvoiceModel.fromJson(Map json)
      : id = json['id'],
        type = json['type'],
        invoiceDate = moment(json['invoice_date']).format(),
        total = json['total'],
        grandTotal = json['grand_total'],
        invoiceNumber = json['invoice_number'],
        taxValue = json['tax_value'],
        createdAt = moment(json['created_at']).format(),
        account = InvoiceAccountModel.fromJson(json['account']),
        products = (json['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList(),
        dueDate = (json['due_date'] != null)
            ? moment(json['due_date']).format()
            : null,
        receiver = ReceiverModel.fromJson(json['receiver']);

  Map toJson() => {
        'id': id,
        'type': type,
        'invoice_date': invoiceDate,
        'total': total,
        'grand_total': grandTotal,
        'invoice_number': invoiceNumber,
        'tax_value': taxValue,
        'created_at': createdAt,
        'account': account,
        'products': products,
        'due_date': dueDate,
        'receiver': receiver
      };
}
