class Unit {
  int? id;
  int? productId;
  final String name;
  final bool active;
  final int salePrice;
  final int coefficient;
  final int purchasePrice;
  final bool addPrice;
  dynamic image;
  String? description;

  Unit({
    required this.name,
    this.active = true,
    this.salePrice = 0,
    this.coefficient = 1,
    this.purchasePrice = 0,
    this.description,
    this.addPrice = false,
  });

  Unit.fromJson(Map json)
      : id = json['id'],
        productId = json['product_id'],
        addPrice = json['add_price'] ?? false,
        name = json['unit'],
        active = [null, 0, false, ''].contains(json['active']) ? false : true,
        image = json['image'],
        salePrice =
            int.tryParse(json['sale_price'].toString()) ?? json['sale_price'],
        purchasePrice = int.tryParse(json['purchase_price'].toString()) ??
            json['purchase_price'],
        description = json['description'],
        coefficient =
            int.tryParse(json['coefficient'].toString()) ?? json['coefficient'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'unit': name,
        'image': image,
        'sale_price': salePrice,
        'purchase_price': purchasePrice,
        'description': description,
        'coefficient': coefficient,
        'active': active ? 1 : 0,
      };
}
