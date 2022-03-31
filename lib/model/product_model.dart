import 'package:my_app/model/category_model.dart';

class Product {
  int? index;
  final int productId;
  final String name;
  final List<dynamic> images;
  List<dynamic>? oldImages;
  final int instock;
  final int price;
  dynamic retailPrice;
  int? buyPrice;

  String? barcode;
  bool enableSelling;
  final String type;
  final List units;
  String? unit;
  final int? categoryId;
  CategoryModel? category;
  int quantity;

  Product({
    required this.productId,
    required this.name,
    required this.images,
    required this.instock,
    required this.price,
    this.retailPrice,
    required this.type,
    required this.units,
    required this.enableSelling,
    required this.categoryId,
    this.quantity = 1,
    this.oldImages,
    this.unit = '1 x Pcs',
  });

  Product.fromJson(Map json)
      : name = json['name'] ?? "hello",
        images = json['images'],
        oldImages = json['images'],
        productId = json['id'],
        instock = json['instock'] ?? 0,
        price = json['price'] ?? 0,
        retailPrice = json['retail_price'] ?? 0,
        buyPrice = json['buy_price'],
        categoryId = json['category_id'],
        category = json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        barcode = json['barcode'],
        type = json['type'] ?? "",
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
        'old_images[]': oldImages,
        'instock': instock,
        'price': price,
        'retail_price': price,
        'type': type,
        'units': units,
        'unit': unit,
        'category_id': categoryId,
        'enable_selling': enableSelling,
        'quantity': quantity,
        "discount": 0,
        "discount_type": "fixed"
      };
}
