import 'package:get/get.dart';

class RegisterParams {
  final String? name;
  final String? companyName;
  final String? email;
  final String? password;
  String? code;
  final address = '';
  final currency = 'MMK';

  RegisterParams(
      {this.name, this.companyName, this.email, this.password, this.code});

  RegisterParams.fromJson(Map json)
      : name = json['full_name'],
        email = json['email'],
        companyName = json['company_name'],
        password = json['password'],
        code = json['code'];

  Map<String, dynamic> toJson() => {
        'full_name': name,
        'email': email,
        'company_name': companyName,
        'password': password,
        'password_confirmation': password,
        'code': code,
        'address': address,
        'currency': currency,
      };
}

class RegisterController extends GetxController {
  final params = Rx<RegisterParams?>(null);
}
