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
    var res = await Api.post(
        '/products/${productOption.productId}/product_units/${productOption.id}',
        data: productOption.toJson(),
        formData: true);
    return res;
  }
}
