import 'package:my_app/model/category_model.dart';

class ProductDetail {
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
  dynamic categoryId;
  CategoryModel? category;
  int quantity;

  ProductDetail({
    required this.productId,
    required this.name,
    required this.images,
    required this.instock,
    required this.price,
    this.retailPrice,
    this.buyPrice,
    this.barcode,
    required this.type,
    required this.units,
    required this.enableSelling,
    required this.categoryId,
    this.quantity = 1,
    this.oldImages,
    this.unit = '1 x Pcs',
  });

  ProductDetail.fromJson(Map json)
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

  ProductDetail.emptyProduct()
      : productId = 0,
        name = '',
        images = [],
        instock = 0,
        price = 0,
        type = 'single',
        units = [],
        enableSelling = false,
        categoryId = 0,
        quantity = 1;

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
        "discount": -1,
        "discount_type": "fixed"
      };
}
