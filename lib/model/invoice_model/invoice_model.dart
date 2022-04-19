import 'package:my_app/helpers/moment.dart';

import 'account_model.dart';
import 'product_model.dart';
import 'receiver_model.dart';

class InvoiceModel {
  final int id;
  final String type;
  final String invoice_date;
  final num total;
  final num grand_total;
  final String invoice_number;
  final num tax_value;
  final String created_at;
  final Map account;
  final List<ProductModel> products;
  final String due_date;
  final Map receiver;

  InvoiceModel({
    required this.id,
    required this.type,
    required this.invoice_date,
    required this.total,
    required this.grand_total,
    required this.invoice_number,
    required this.tax_value,
    required this.created_at,
    required this.account,
    required this.products,
    required this.due_date,
    required this.receiver,
  });

  InvoiceModel.fromJson(Map json) :
    id = json['id'],
    type = json['type'],
    invoice_date =  moment(json['invoice_date']).format(),
    total = json['total'],
    grand_total = json['grand_total'],
    invoice_number = json['invoice_number'],
    tax_value = json['tax_value'],
    created_at = moment(json['created_at']).format(),
    account = AccountModel.fromJson(json['account']).toJson(),
    products = ( json['products'] as List ).map((e) => ProductModel.fromJson(e)).toList(),
    due_date = ( json['due_date'] != null ) ? moment(json['due_date']).format() : '',
    receiver = ReceiverModel.fromJson(json['receiver']).toJson();
  
  Map toJson() => {
    'id' : id,
    'type' : type,
    'invoice_date' : invoice_date,
    'total' : total,
    'grand_total' : grand_total,
    'invoice_number' : invoice_number,
    'tax_value' : tax_value,
    'created_at' : created_at,
    'account' : account,
    'products' : products,
    'due_date' : due_date,
    'receiver' : receiver
  };
}
