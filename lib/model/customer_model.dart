class CustomerModel {
  final String name;
  final int? id;
  final String? image;
  final String? email;

  CustomerModel({
    required this.name,
    required this.id,
    required this.image,
    this.email,
  });

  CustomerModel.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'][0] ?? '',
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'email': email,
        'image': image,
      };
}
