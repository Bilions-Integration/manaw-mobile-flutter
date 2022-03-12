import 'package:my_app/model/company_model.dart';

class User {
  final String name;
  final String email;
  final String plan;
  final String? startDate;
  final String? expiredDate;
  final String userType;
  final Company company;
  final String? phone;
  final String image;

  User({
    required this.name,
    required this.email,
    required this.plan,
    this.startDate,
    this.phone,
    required this.image,
    required this.company,
    required this.userType,
    this.expiredDate,
  });

  User.fromJson(Map json)
      : name = json['full_name'],
        email = json['email'],
        phone = json['phone'],
        startDate = json['start_date'],
        userType = json['user_type'],
        image = json['profile_image'] ?? '',
        expiredDate = json['expired_date'],
        company = Company.fromJson(json['company']),
        plan = json['plan'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': email,
        'phone': phone,
        'profile_image': image,
        'plan': plan,
        'start_date': startDate,
        'user_type': userType,
        'expired_date': expiredDate,
      };
}
