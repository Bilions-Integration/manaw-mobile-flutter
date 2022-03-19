class Product {
  final int productId;
  int? index;
  final String name;
  final List<dynamic> images;
  final int instock;
  final int price;
  final String type;
  final List units;
  bool enableSelling;
  String? retailPrice;
  int quantity;

  Product({
    required this.productId,
    required this.name,
    required this.images,
    required this.instock,
    required this.price,
    required this.type,
    required this.units,
    required this.enableSelling,
    this.quantity = 1,
  });

  Product.fromJson(Map json)
      : name = json['name'],
        images = json['images'],
        productId = json['id'],
        instock = json['instock'],
        price = json['price'] ?? 0,
        retailPrice = json['retail_price'] ?? '',
        type = json['type'],
        enableSelling = json['enable_selling'] ?? false,
        quantity = json['quantity'] ?? 1,
        units = json['units'] ?? [];

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
        'enable_selling': enableSelling,
        'quantity': quantity,
        "discount": 0,
        "discount_type": "fixed"
      };
}
