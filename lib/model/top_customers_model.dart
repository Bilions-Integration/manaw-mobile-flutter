class TopCustomersModel {
  int id;
  String name;
  String image;
  int amount;

  TopCustomersModel({
    required this.id,
    required this.name,
    required this.image,
    required this.amount,
  });

  factory TopCustomersModel.fromJson(Map<String, dynamic> json) {
    return TopCustomersModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      amount: json['amount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'amount': amount,
      };
}
