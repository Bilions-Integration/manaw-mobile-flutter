import 'package:get/get.dart';

class ForgetPasswordParams {
  final String? email;
  final String? password;
  String? code;

  ForgetPasswordParams({this.email, this.password, this.code});

  ForgetPasswordParams.fromJson(Map json)
      : email = json['email'],
        password = json['password'],
        code = json['code'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'password_confirmation': password,
        'code': code,
      };
}

class ForgetPasswordController extends GetxController {
  final params = Rx<ForgetPasswordParams?>(null);
}
