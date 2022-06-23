import 'package:get/get.dart';

class RegisterParams {
  final String? name;
  final String? companyName;
  final String? email;
  final String? password;
  String? code;
  final address = '';
  final currency = 'MMK';
  final String? referralCode;

  RegisterParams(
      {this.name,
      this.companyName,
      this.email,
      this.password,
      this.code,
      this.referralCode});

  RegisterParams.fromJson(Map json)
      : name = json['full_name'],
        email = json['email'],
        companyName = json['company_name'],
        password = json['password'],
        code = json['code'],
        referralCode = json['referral_code'];

  Map<String, dynamic> toJson() => {
        'full_name': name,
        'email': email,
        'company_name': companyName,
        'password': password,
        'password_confirmation': password,
        'code': code,
        'address': address,
        'currency': currency,
        'referral_code': referralCode,
      };
}

class RegisterController extends GetxController {
  final params = Rx<RegisterParams?>(null);
}
