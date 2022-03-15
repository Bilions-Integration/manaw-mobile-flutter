import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';

class ProfileService {
  static Future setName(String name) async {
    await Api.post('/change/name', data: {"full_name": name});
  }

  static Future setImage(MyFile image) async {
    return await Api.post(
      '/change/profile_image',
      data: {"profile_image": image.blob},
      formData: true,
    );
  }

  static Future requestChangeEmailOTP(String email) async {
    return await Api.post('/change/email', data: {"email": email});
  }

  static Future verifyChangeEmailOTP(String? email, String code) async {
    try {
      if (email != null) {
        var res = await Api.post('/change/email/enter_code', data: {
          "email": email,
          "code": code,
        });
        console.log(res);
        if (res['code'] != 200) {
          throw res['error'];
        }
      }
    } catch (e) {
      alert(title: e.toString());
    }
  }
}
