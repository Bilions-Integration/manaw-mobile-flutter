import 'package:my_app/model/unit_model.dart';

class ProductModel {
  final int productId;
  final num quantity;
  final num price;
  Unit? unit;
  final String? name;

  ProductModel(
    this.productId,
    this.quantity,
    this.price,
    this.name,
    this.unit,
  );

  ProductModel.fromJson(Map json)
      : productId = json['product_id'],
        quantity = json['quantity'],
        price = json['price'],
        unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null,
        name = (json['selected_product'] as Map)['name'] ?? '';

  Map toJson() => {
        'product_id': productId,
        'quantity': quantity,
        'price': price,
        'name': name,
      };
}
