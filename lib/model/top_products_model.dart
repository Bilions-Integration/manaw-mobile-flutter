import 'package:my_app/data/assets.dart';

class TopProductsModel {
  String name;
  String image;
  int totalQuantity;
  int instock;
  num percent;

  TopProductsModel({
    required this.name,
    required this.image,
    required this.totalQuantity,
    required this.instock,
    required this.percent,
  });

  factory TopProductsModel.fromJson(Map<String, dynamic> json) => TopProductsModel(
        name: json['name'] ?? '',
        image: json['images'][0] ?? AppAssets.placeholder,
        totalQuantity: json['total_quantity'],
        instock: json['instock'] ?? 0,
        percent: json['percent'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'images': image,
        'total_quantity': totalQuantity,
        'instock': instock,
        'percent': percent,
      };
}
