class ProductModel {
  final int productId;
  final num quantity;
  final num price;
  final String? name;

  ProductModel(this.productId, this.quantity, this.price, this.name);

  ProductModel.fromJson(Map json)
      : productId = json['product_id'],
        quantity = json['quantity'],
        price = json['price'],
        name = (json['selected_product'] as Map)['name'] ?? '';

  Map toJson() => {
        'product_id': productId,
        'quantity': quantity,
        'price': price,
        'name': name,
      };
}
