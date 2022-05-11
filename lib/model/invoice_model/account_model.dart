class AccountModel {
  final String bank_name;

  AccountModel({required this.bank_name});

  AccountModel.fromJson(Map json) : bank_name = json['bank_name'] ?? '';

  Map toJson() => {'bank_name': bank_name};
}
