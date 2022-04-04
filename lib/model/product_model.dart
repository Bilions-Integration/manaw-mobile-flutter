class Product {
  final int productId;
  int? index;
  final String name;
  final List<dynamic> images;
  final int instock;
  final int price;
  final String type;
  final List units;
  int quantity;

  Product({
    required this.productId,
    required this.name,
    required this.images,
    required this.instock,
    required this.price,
    required this.type,
    required this.units,
    this.quantity = 1,
  });

  Product.fromJson(Map json)
      : name = json['name'],
        images = json['images'],
        productId = json['id'],
        instock = json['instock'],
        price = json['price'],
        type = json['type'],
        quantity = json['quantity'] ?? 1,
        units = json['units'];

  Map<String, dynamic> toJson() => {
        'index': index,
        'name': name,
        'product_id': productId,
        'id': productId,
        'images': images,
        'instock': instock,
        'price': price,
        'type': type,
        'units': units,
        'quantity': quantity,
        "discount": 0,
        "discount_type": "fixed"
      };
}
