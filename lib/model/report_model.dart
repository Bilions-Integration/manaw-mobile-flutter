import 'package:my_app/helpers/moment.dart';
import 'package:my_app/model/account_model/account_model.dart';
import 'package:my_app/model/customer_model.dart';

class Report {
  final int id;
  final String invoiceNumber;
  final int quantity;
  final num unitPrice;
  final num unitSalePrice;
  final num totalSalePrice;
  final String currency;
  final String name;
  final String unit;
  final String createdAt;
  final AccountModel? account;
  final CustomerModel? customer;

  Report.fromJson(Map json)
      : id = json['id'],
        invoiceNumber = json['invoice_number'],
        quantity = json['quantity'],
        unitPrice = json['unit_price'],
        unitSalePrice = json['unit_sale_price'],
        totalSalePrice = json['total_sale_price'],
        currency = json['currency'],
        name = json['name'],
        unit = json['unit'],
        createdAt =
            moment.onlyDate(moment.string(DateTime.parse(json['created_at']))),
        customer = json['customer'] != null
            ? CustomerModel.fromJson(json['customer'])
            : null,
        account = json['account'] != null
            ? AccountModel.fromJson(json['account'])
            : null;
}
