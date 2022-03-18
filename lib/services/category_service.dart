import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/category_model.dart';

class CategoryService {
  static Future<List<CategoryModel>> get() async {
    var res = await Api.get('/categories', data: {"page": 1, "limit": 50});
    List<CategoryModel> categories = (res["data"]["data"] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    return categories;
  }
}
