
import 'invoice_model.dart';

class InvoiceDataModel {
  final List<InvoiceModel> invoices;
  final int total;
  final bool last_page;

  InvoiceDataModel({
    required this.invoices,
    required this.total,
    required this.last_page,
  });

  InvoiceDataModel.fromJson(Map json) : 
    invoices = ( json['data'] as List ).map((e) => InvoiceModel.fromJson(e)).toList(),
    total = json['total'], 
    last_page = json['last_page'];

  Map<String, dynamic> toJson() => {
    'invoices' : invoices,
    'total' : total, 
    'last_page' : last_page
  };
}