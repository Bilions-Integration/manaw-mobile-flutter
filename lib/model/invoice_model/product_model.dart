class ProductModel {
  final int product_id;
  final num quantity;
  final num price;
  final String? name;

  ProductModel(
    this.product_id, 
    this.quantity, 
    this.price, 
    this.name
  );
  
  ProductModel.fromJson(Map json) : 
    product_id = json['product_id'], 
    quantity = json['quantity'], 
    price = json['price'],
    name = ( json['selected_product'] as Map )['name'] ?? '';

  Map toJson() => { 
    'product_id' : product_id, 
    'quantity' : quantity,
    'price' : price,
    'name' : name,
  };

}