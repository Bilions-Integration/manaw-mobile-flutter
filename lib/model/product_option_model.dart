class ProductOption {
  int? id;
  int? productId;
  final String name;
  final bool active;
  final int salePrice;
  final int coefficient;
  final int purchasePrice;
  dynamic image;
  String? description;

  ProductOption({
    required this.name,
    this.active = true,
    this.salePrice = 0,
    this.coefficient = 1,
    this.purchasePrice = 0,
    this.description,
  });

  ProductOption.fromJson(Map json)
      : id = json['id'],
        productId = json['product_id'],
        name = json['unit'],
        active = json['active'],
        image = json['image'],
        salePrice =
            int.tryParse(json['sale_price'].toString()) ?? json['sale_price'],
        purchasePrice = int.tryParse(json['purchase_price'].toString()) ??
            json['purchase_price'],
        description = json['description'],
        coefficient =
            int.tryParse(json['coefficient'].toString()) ?? json['coefficient'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'unit': name,
        'image': image,
        'sale_price': salePrice,
        'purchase_price': purchasePrice,
        'description': description,
        'coefficient': coefficient,
        'active': active,
      };
}

/*
 "id": 201,
 "product_id": 11,
 "type": "product",
 "company_id": 3,
 "unit": "Stay",
 "coefficient": 1,
 "image": "https:\/\/api.manawstore.xyz\/image\/product_units\/FqCROryAmlyYBIJQACGRzD0SkGheWC5zMbbBffwX.jpg",
 "sale_price": 1000,
 "purchase_price": 1000,
 "description": null,
 "is_default": false,
 "created_at": "2022-04-05T07:51:59.000000Z",  "updated_at": "2022-04-05T07:51:59.000000Z",
 "active": true
 */
