class ProductModel {
  final int product_id;
  final num quantity;
  final num price;

  ProductModel(
    this.product_id, 
    this.quantity, 
    this.price
  );
  
  ProductModel.fromJson(Map json) : 
    product_id = json['product_id'], 
    quantity = json['quantity'], 
    price = json['price'];

  Map toJson() => { 
    'product_id' : product_id, 
    'quantity' : quantity,
    'price' : price,
  };

}