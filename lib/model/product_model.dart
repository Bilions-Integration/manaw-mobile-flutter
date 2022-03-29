import 'package:my_app/model/category_model.dart';

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
  dynamic retailPrice;
  int? purchasePrice;
  String? barcode;
  final int categoryId;
  CategoryModel? category;
  String? unit;
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
    required this.categoryId,
    this.quantity = 1,
  });

  Product.fromJson(Map json)
      : name = json['name'],
        images = json['images'],
        productId = json['id'],
        instock = json['instock'] ?? 0,
        price = json['price'] ?? 0,
        retailPrice = json['retail_price'] ?? '',
        purchasePrice = json['buy_price'],
        categoryId = json['category_id'] ?? 0,
        category = json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        barcode = json['barcode'],
        type = json['type'],
        enableSelling = json['enable_selling'] ?? false,
        quantity = json['quantity'] ?? 1,
        units = json['units'] ?? [],
        unit = json['unit'];

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
