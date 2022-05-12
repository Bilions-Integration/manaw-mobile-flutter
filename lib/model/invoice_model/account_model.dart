class AccountModel {
  final String? bankName;

  AccountModel({this.bankName});

  factory AccountModel.fromJson(Map? json) {
    if(json != null) {
      return AccountModel(
        bankName: json['bank_name'] as String?
      );
    } else {
     return AccountModel();
    }
  }

  Map toJson() => {
        'bank_name': bankName,
      };
}
