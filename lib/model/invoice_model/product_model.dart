import 'package:my_app/model/unit_model.dart';

class ProductModel {
  final int productId;
  final num quantity;
  final num price;
  Unit? unit;
  final String? name;
  final String? note;

  ProductModel(
    this.productId,
    this.quantity,
    this.price,
    this.name,
    this.unit,
    this.note,
  );

  ProductModel.fromJson(Map json)
      : productId = json['product_id'],
        quantity = json['quantity'],
        price = json['price'],
        unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null,
        note = json['note'],
        name = (json['selected_product'] as Map)['name'] ?? '';

  Map toJson() => {
        'product_id': productId,
        'quantity': quantity,
        'price': price,
        'name': name,
        'note': note,
      };
}
