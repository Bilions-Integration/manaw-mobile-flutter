import 'package:my_app/helpers/api.dart';

class ProductOptionController {
  Future createOption(
      {showLoading = false,
      required Map<String, dynamic> productOption,
      required int productId}) async {
    var res = await Api.post('/products/$productId/product_units',
        data: productOption, formData: true, showLoading: showLoading);
    if (res['success']) {
      return res;
    } else {
      throw res['error'];
    }
  }

  Future updateOption({required Map<String, dynamic> productOption}) async {
    var res = await Api.post(
        '/products/${productOption['product_id']}/product_units/${productOption['id']}/?_method=PUT',
        data: productOption,
        formData: true);
    if (res['success']) {
      return res;
    } else {
      throw res['error'];
    }
  }

  Future<bool> deleteOption({required int id, required productId}) async {
    var res = await Api.delete('/products/$productId/product_units/$id',
        showLoading: false);
    return res['success'];
  }
}
