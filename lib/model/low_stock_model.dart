import 'dart:convert';

class LowStockModel {
  int? id;
  String? name;
  List<String>? images;
  int? instock;

  LowStockModel({this.id, this.name, this.images, this.instock});

  factory LowStockModel.fromMap(Map<String, dynamic> data) => LowStockModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        images: data['images'] as List<String>?,
        instock: data['instock'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'images': images,
        'instock': instock,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LowStockModel].
  factory LowStockModel.fromJson(String data) {
    return LowStockModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LowStockModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
