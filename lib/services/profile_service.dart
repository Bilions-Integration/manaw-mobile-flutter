import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';

class ProfileService {
  static Future changePassword({
    required String? password,
    required String? confirmPassword,
  }) async {
    if ((password != null && password.isEmpty) ||
        password == null ||
        password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Password Required or the two passwords did not match!',
        icon: const Icon(Icons.info),
      );
      return false;
    }
    return await Api.post('/change/password', data: {
      "password": password,
      "confirm_password": confirmPassword,
    });
  }

  static Future requestChangeEmailOTP(String email) async {
    return await Api.post('/change/email', data: {"email": email});
  }

  static Future setImage(MyFile image) async {
    return await Api.post(
      '/change/profile_image',
      data: {"profile_image": image.blob},
      formData: true,
    );
  }

  static Future setName(String name) async {
    await Api.post('/change/name', data: {"full_name": name});
  }

  static Future verifyChangeEmailOTP(String? email, String code) async {
    try {
      if (email != null) {
        var res = await Api.post('/change/email/enter_code', data: {
          "email": email,
          "code": code,
        });
        if (res['code'] != 200) {
          throw res['error'];
        }
        return true;
      }
    } catch (e) {
      alert(title: e.toString());
      return false;
    }
  }
}
