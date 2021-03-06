import 'package:my_app/model/unit_model.dart';

class Product {
  final int productId;
  int? index;
  final String name;
  final List<dynamic> images;
  final int instock;
  int price;
  final String type;
  final List<Unit> units;
  Unit? unit;
  int quantity;
  String? note;

  Product({
    required this.productId,
    required this.name,
    required this.images,
    required this.instock,
    required this.price,
    required this.type,
    required this.units,
    this.quantity = 1,
    this.note,
  });

  Product.fromJson(Map json)
      : name = json['name'],
        images = json['images'],
        productId = json['id'],
        instock = json['instock'],
        price = json['price'],
        type = json['type'],
        note = json['note'],
        quantity = json['quantity'] ?? 1,
        unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null,
        units = (json['units'] as List).map((e) => Unit.fromJson(e)).toList();

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
        "discount_type": "fixed",
        "note": note,
      };
}
