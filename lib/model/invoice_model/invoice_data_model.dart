import 'invoice_model.dart';

class InvoiceDataModel {
  final List<InvoiceModel> invoices;
  final int total;
  final bool lastPage;

  InvoiceDataModel({
    required this.invoices,
    required this.total,
    required this.lastPage,
  });

  InvoiceDataModel.fromJson(Map json)
      : invoices = (json['data'] as List)
            .map((e) => InvoiceModel.fromJson(e))
            .toList(),
        total = json['total'],
        lastPage = json['last_page'];

  Map<String, dynamic> toJson() => {
        'invoices': invoices,
        'total': total,
        'last_page': lastPage,
      };
}
