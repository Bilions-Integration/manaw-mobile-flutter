import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/product_option_model.dart';

class ProductDetail {
  int? index;
  final int productId;
  final String name;
  final List<dynamic> images;
  final List? oldImages;
  final int instock;
  final dynamic retailPrice;
  final int? buyPrice;

  final String? barcode;
  final bool enableSelling;
  final String type;
  final List<ProductOption> units;
  final String? unit;
  dynamic categoryId;
  CategoryModel? category;
  int quantity;

  ProductDetail({
    required this.productId,
    required this.name,
    required this.images,
    required this.instock,
    required this.retailPrice,
    required this.type,
    required this.units,
    required this.enableSelling,
    required this.categoryId,
    this.buyPrice,
    this.barcode,
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
        units = (json['units'] as List)
            .map((e) => ProductOption.fromJson(e))
            .toList(),
        unit = json['unit'];

  ProductDetail.emptyProduct()
      : productId = 0,
        name = '',
        images = [],
        oldImages = [],
        instock = 0,
        retailPrice = 0,
        barcode = '',
        buyPrice = 0,
        unit = '',
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
        'images[]': images,
        'old_images[]': oldImages,
        'instock': instock,
        'retail_price': retailPrice,
        'type': type,
        'unit': unit,
        'category_id': categoryId,
        'enable_selling': enableSelling,
        'quantity': quantity,
      };
}
