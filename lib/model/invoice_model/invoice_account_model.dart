class InvoiceAccountModel {
  final String? bankName;

  InvoiceAccountModel({this.bankName});

  factory InvoiceAccountModel.fromJson(Map? json) {
    if (json != null) {
      return InvoiceAccountModel(bankName: json['bank_name'] as String?);
    } else {
      return InvoiceAccountModel();
    }
  }

  Map toJson() => {
        'bank_name': bankName,
      };
}
