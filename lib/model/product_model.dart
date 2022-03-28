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

/* {id: 70,
company_id: 32,
name: Leaves,
retail_price: 50000,
original_price: 50000,
instock: null,
apo_obs: true,
n_stock: false,
images: [https://api.manawstore.com/image/products/HGxD7LHoDM6QH5zSZlvspYyvyj67L55eTXp45rs3.jpg],
category_id: 33,
enable_selling: true,
deleted_at: null,
created_at: 2022-03-13 04:51:47,
updated_at: 2022-03-17 03:48:08,
barcode: 44525233,
sku: null,
parent_id: null,
type: product,
group_name: null,
is_single: true,
active: 1,
buy_price: 50000,
unit: 1 x Pcs,
category: {id: 33, name: Other, image: https://api.manawstore.com/placeholder.png, created_at: 2022-03-17T03:47:20.000000Z, updated_at: 2022-03-17T03:47:20.000000Z, company_id: 32, deleted_at: null},
units: [{id: 154, product_id: 70, type: product, company_id: 32, unit: 1 x Dozen, coefficient: 12, sale_price: 0, purchase_price: 0, description: null, is_default: true, created_at: 2022-03-13T11:21:47.000000Z, updated_at: 2022-03-17T03:48:08.000000Z, active: 0}],
sub_products
 */
