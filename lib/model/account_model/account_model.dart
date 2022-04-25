class AccountModel {
  int? id;
  num? coa;
  String ownerName;
  String? accountNumber;
  String? bankName;
  num? initialAmount;
  num? currentAmount;
  int? companyId;
  dynamic currentBalance;

  AccountModel({
    this.id,
    this.coa,
    required this.ownerName,
    this.accountNumber,
    this.bankName,
    this.initialAmount,
    this.currentAmount,
    this.companyId,
    this.currentBalance,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
      id: json['id'] as int?,
      coa: json['coa'] as num?,
      ownerName: json['owner_name'] as String,
      accountNumber: json['account_number'] as String?,
      bankName: json['bank_name'] as String?,
      initialAmount: json['initial_amount'] as num?,
      currentAmount: json['current_amount'] as num?,
      companyId: json['company_id'] as int?,
      currentBalance: json['current_balance']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'coa': coa,
        'owner_name': ownerName,
        'account_number': accountNumber,
        'bank_name': bankName,
        'initial_amount': initialAmount,
        'current_amount': currentAmount,
        'company_id': companyId,
        'current_balance': currentBalance,
      };
}
