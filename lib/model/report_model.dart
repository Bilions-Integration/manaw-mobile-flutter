import 'package:my_app/helpers/moment.dart';
import 'package:my_app/model/account_model/account_model.dart';
import 'package:my_app/model/customer_model.dart';
import 'package:my_app/model/invoice_model/invoice_model.dart';
import 'package:my_app/model/invoice_model/receiver_model.dart';

class Report {
  final int id;
  final String invoiceNumber;
  final String? invoiceDate;
  final num? invoiceTotalPrice;
  final int quantity;
  final num unitPrice;
  final num unitSalePrice;
  final num totalSalePrice;
  final String currency;
  final String name;
  final String unit;
  final String createdAt;
  final AccountModel? account;
  final ReceiverModel? customer;

  Report.fromJson(Map json)
      : id = json['id'],
        invoiceNumber =
            json['invoice_number'] ?? json['invoice']['invoice_number'],
        invoiceDate = json['invoice']?['invoice_date'] ?? '',
        invoiceTotalPrice = json['invoice']?['total_price'] ?? 0,
        quantity = json['quantity'],
        unitPrice = json['unit_price'],
        unitSalePrice = json['unit_sale_price'],
        totalSalePrice = json['total_sale_price'],
        currency = json['currency'],
        name = json['name'] ?? json['product']['name'],
        unit = json['unit'] ?? '',
        createdAt =
            moment.onlyDate(moment.string(DateTime.parse(json['created_at']))),
        customer = json['receiver'] != null
            ? ReceiverModel.fromJson(json['receiver'])
            : null,
        account = json['account'] != null
            ? AccountModel.fromJson(json['account'])
            : null;
}
