import 'package:my_app/model/company_model.dart';

class User {
  String name;
  String email;
  String plan;
  String? startDate;
  String? expiredDate;
  String userType;
  Company company;
  String? phone;
  String image;

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
        email = json['email'] ?? '',
        phone = json['phone'],
        startDate = json['start_date'],
        userType = json['user_type'],
        image = json['profile_image'] ?? '',
        expiredDate = json['expired_date'],
        company = Company.fromJson(json['company']),
        plan = json['plan'];

  Map<String, dynamic> toJson() => {
        'full_name': name,
        'email': email,
        'phone': phone,
        'profile_image': image,
        'plan': plan,
        'start_date': startDate,
        'user_type': userType,
        'expired_date': expiredDate,
        'company': company.toJson()
      };
}
