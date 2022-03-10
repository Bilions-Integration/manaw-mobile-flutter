class Product {
  final int id;
  final String name;
  final List<dynamic> images;
  final int instock;
  final int price;
  final String type;
  final List units;

  Product({
    required this.id,
    required this.name,
    required this.images,
    required this.instock,
    required this.price,
    required this.type,
    required this.units,
  });

  Product.fromJson(Map json)
      : name = json['name'],
        images = json['images'],
        id = json['id'],
        instock = json['instock'],
        price = json['price'],
        type = json['type'],
        units = json['units'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'images': images,
        'instock': instock,
        'price': price,
        'type': type,
        'units': units,
      };
}
