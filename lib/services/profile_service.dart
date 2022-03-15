import 'package:my_app/helpers/api.dart';

class ProfileService {
  static Future setName(String name) async {
    await Api.post('/change/name', data: {"full_name": name});
  }
}
