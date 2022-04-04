import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/category_model.dart';

class CategoryService {
  static Future<Map<String, dynamic>> get(Map<String, dynamic> params) async {
    var res = await Api.get('/categories', data: params, showLoading : false);
    var data = CategoryDataModel.fromJson(res["data"]).toJson();
    return data;
  }

  static Future create(Map params) async {
    await Api.post('/categories', data : params, formData: true);
    return 'success';
  }

  static Future<Map<String, dynamic>> fetch(int? id) async {
    var res = await Api.get('/categories/$id', showLoading : false);
    Map<String, dynamic> category =  CategoryModel.fromJson(res["data"]).toJson();
    return category;
  }

  static Future delete(int? id) async {
    await Api.delete('/categories/$id');
    return 'success';
  }

  static Future update(int? id, Map params) async {
    await Api.post('/categories/$id?_method=PUT', data : params, formData: true);
    return 'success';
  }
}
