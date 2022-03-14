class CategoryModel {
  final String name;
  final int? id;
  final dynamic image;

  CategoryModel({
    required this.name,
    required this.id,
    required this.image,
  });

  CategoryModel.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'image': image,
      };
}
