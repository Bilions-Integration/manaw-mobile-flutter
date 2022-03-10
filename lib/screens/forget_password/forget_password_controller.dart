import 'package:get/get.dart';

class ForgetPasswordParams {
  final String? email;
  String? password;
  String? passwordConfirmation;
  String? code;

  ForgetPasswordParams(
      {this.email, this.password, this.code, this.passwordConfirmation});

  ForgetPasswordParams.fromJson(Map json)
      : email = json['email'],
        password = json['password'],
        code = json['code'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'code': code,
      };
}

class ForgetPasswordController extends GetxController {
  final params = Rx<ForgetPasswordParams?>(null);
}
