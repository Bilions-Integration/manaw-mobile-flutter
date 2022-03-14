class Account {
  final String name;
  final int id;
  final dynamic currentBalance;
  Account({
    required this.name,
    required this.id,
    required this.currentBalance,
  });

  Account.fromJson(Map json)
      : id = json['id'],
        name = json['owner_name'],
        currentBalance = json['current_balance'];

  Map<String, dynamic> toJson() => {
        'owner_name': name,
        'id': id,
        'current_Balance': currentBalance,
      };
}
