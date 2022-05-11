class AccountModel {
  final String bankName;

  AccountModel({required this.bankName});

  AccountModel.fromJson(Map json) : bankName = json['bank_name'] ?? '';

  Map toJson() => {
        'bank_name': bankName,
      };
}
