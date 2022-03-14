import 'package:my_app/helpers/helper.dart';

class CustomerModel {
  final String name;
  final int? id;
  final String? image;
  final String? email;
  final String? phone;
  final String? address;
  final String? taxId;

  CustomerModel({
    required this.name,
    required this.id,
    required this.image,
    this.email,
    this.phone,
    this.address,
    this.taxId,
  });

  CustomerModel.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        phone = _getData(json, 'phone'),
        taxId = json['tax_id'],
        address = json['address'],
        email = _getData(json, 'email'),
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'email': email,
        'image': image,
        'address': address,
        'tax_id': taxId,
        'phone': phone,
      };
}

String _getData(json, column) {
  try {
    return json[column] != null && !empty(json[column][0]) ? json[column][0] : '';
  } catch (e) {
    return '';
  }
}
