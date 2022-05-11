import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/company_model.dart';

class CompanyService {
  static Future<Map<String, dynamic>> fetch() async {
    final auth = Get.find<AuthController>();
    int? id = auth.user.value?.company.id;

    var res = await Api.get('/companies/$id', showLoading: false);
    Map<String, dynamic> data = Company.fromJson(res["data"]).toJson();
    return data;
  }

  static Future setColor(String color) async {
    await Api.post('/company/setting/color', data: {"color": color});
  }

  static Future update(Map<String, dynamic> params) async {
    var res = await Api.post('/companies/${params["id"]}',
        data: params, formData: true);
    return res;
  }
}
