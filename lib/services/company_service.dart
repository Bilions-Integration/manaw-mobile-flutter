import 'package:my_app/helpers/api.dart';

class CompanyService {
  static Future setColor(String color) async {
    await Api.post('/company/setting/color', data: {"color": color});
  }
}
