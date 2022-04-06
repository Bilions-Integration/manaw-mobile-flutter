import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/product_option_model.dart';

class ProductOptionController {
  Future createOption(
      {showLoading = false,
      required ProductOption productOption,
      required int productId}) async {
    var res = await Api.post('/products/$productId/product_units',
        data: productOption.toJson(), formData: true, showLoading: showLoading);
    return res;
  }

  Future updateOption({required ProductOption productOption}) async {
    var res = await Api.post('?_method=PUT',
        data: productOption.toJson(), formData: true);
    return res;
  }

  Future deleteOption({required int id, required productId}) async {
    var res = await Api.delete('/products/$productId/product_units/$id',
        showLoading: false);
    return res;
  }
}
