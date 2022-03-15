import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';

class ProfileService {
  static Future setName(String name) async {
    await Api.post('/change/name', data: {"full_name": name});
  }

  static Future setImage(MyFile image) async {
    console.log(image.blob);
    return await Api.post(
      '/change/profile_image',
      data: {"profile_image": image.blob},
      formData: true,
    );
  }
}
