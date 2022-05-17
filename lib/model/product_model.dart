import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_option_model.dart';
import 'package:my_app/model/unit_model.dart';

class Product {
  final int productId;
  int? index;
  final String name;
  final List<dynamic> images;
  final int instock;
  int price;
  final String type;
  final List<ProductOption> units;
  ProductOption? unit;
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
        unit =
            json['unit'] != null ? ProductOption.fromJson(json['unit']) : null,
        units = (json['units'] as List)
            .map((e) => ProductOption.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'index': index,
        'name': name,
        'product_id': productId,
        'id': productId,
        'images': images,
        'instock': instock,
        'price': price,
        'type': type,
        'units': units.map((e) => e.toJson()).toList(),
        'unit': unit?.toJson(),
        'quantity': quantity,
        "discount": 0,
        "discount_type": "fixed"
      };
}
