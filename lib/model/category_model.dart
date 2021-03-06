class CategoryDataModel {
  final List<CategoryModel> categories;
  final int total;
  final bool lastPage;

  CategoryDataModel({
    required this.categories,
    required this.total,
    required this.lastPage,
  });

  factory CategoryDataModel.fromJson(Map json) {
    List data = json['data'] as List;
    List<CategoryModel> categories =
        data.map((e) => CategoryModel.fromJson(e)).toList();

    return CategoryDataModel(
      categories: categories,
      total: json['total'],
      lastPage: json['last_page'],
    );
  }

  Map<String, dynamic> toJson() => {
        'categories': categories,
        'total': total,
        'last_page': lastPage,
      };
}

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
