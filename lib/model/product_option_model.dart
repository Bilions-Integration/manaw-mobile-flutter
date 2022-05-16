class ProductOption {
  int? id;
  int? productId;
  final String name;
  final bool active;
  final int salePrice;
  final int coefficient;
  final int purchasePrice;
  dynamic image;
  String? description;

  ProductOption({
    required this.name,
    this.active = true,
    this.salePrice = 0,
    this.coefficient = 1,
    this.purchasePrice = 0,
    this.description,
  });

  ProductOption.fromJson(Map json)
      : id = json['id'],
        productId = json['product_id'],
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
